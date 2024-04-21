import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './widgets/ProductResultsScreen.dart';

class Scan {
  late List<CameraDescription> cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> disposeCamera() async {
    await _controller.dispose();
  }

  Future<String> takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      return image.path;
    } catch (e) {
      print(e);
      return '';
    }
  }
}

Future<void> queryProduct(String query,Function(List<Map<String, dynamic>>) onResults) async {
  // Fetch all products from Firestore
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Products')
      .get();

  // Convert the query to lowercase for case-insensitive comparison
  String normalizedQuery = query.toLowerCase();
  List<Map<String, dynamic>> matchedProducts = [];

  // Iterate through each document in the query snapshot
  for (var doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String productName = data['Name'].toString().toLowerCase();

    // Check if the product name contains the query string
    if (productName.contains(normalizedQuery)) {
        matchedProducts.add(data);
        print('Product found: $data');
    }
  }

  if (matchedProducts.isEmpty) {
    print('No products found for: $query');
  }
  onResults(matchedProducts); 
}



class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  final Scan _scan = Scan();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    await _scan.initializeCamera();
    setState(() {}); // Update the UI after initializing the camera
  }

  @override
  void dispose() {
    _scan.disposeCamera();
    super.dispose();
  }


 Future<void> _processImage(BuildContext context, String imagePath) async {
  final inputImage = InputImage.fromFilePath(imagePath);
  String imgPath = imagePath;
  final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  List<Map<String, dynamic>> allMatchedProducts = [];

  try {
    final RecognizedText result = await textRecognizer.processImage(inputImage);
    List<String> words = result.blocks
        .expand((b) => b.lines)
        .expand((line) => line.text.split(' '))
        .where((word) => word.length > 1)
        .toSet()
        .toList();

    for (String word in words) {
      await queryProduct(word, (List<Map<String, dynamic>> matchedProducts) {
        allMatchedProducts.addAll(matchedProducts);
      });
    }
    if (allMatchedProducts.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductResultsScreen(matchedProducts: allMatchedProducts, imagePath:imgPath),
            ),
          );
        }
  } catch (e) {
    print('Error processing image: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to recognize text from the image.'),
    ));
  } finally {
    textRecognizer.close();
  }
}



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Click Picture of the Product')),
        body: _scan.cameras.isEmpty
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<void>(
                future: _scan._initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_scan._controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _scan.cameras.isEmpty
              ? null
              : () async {
                  final imagePath = await _scan.takePicture();
                  if (imagePath.isNotEmpty) {
                    await _processImage(context,imagePath);
                  } else {
                    // Show a snackbar or dialog to inform the user about the error
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Failed to take a picture.'),
                    ));
                  }
                },
          child: Icon(Icons.camera_alt),
        ),
      ),
    );
  }
}