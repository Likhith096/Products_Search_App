import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'package:googleapis/vision/v1.dart' as vision;
import 'package:googleapis_auth/auth_io.dart';


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


  Future<void> _processImage(String imagePath) async {
  // Load the image file from the local path
  final imageBytes = File(imagePath).readAsBytesSync();

  // Convert the Uint8List to a base64 encoded string
  final base64Image = base64Encode(imageBytes);

  // Create a JSON request payload
  final requestJson = {
    "requests": [
      {
        "image": {"content": base64Image},
        "features": [{"type": "LABEL_DETECTION"}]
      }
    ]
  };

  // Make a POST request to the Vision API
  final apiKey = 'AIzaSyCox3nrjBmRiVltV-q_7ONXbcQzI_unHCw'; // Replace with your actual API key
  final response = await HttpClient().postUrl(Uri.parse(
      'https://vision.googleapis.com/v1/images:annotate?key=$apiKey'));
  response.headers.contentType =
      ContentType('application', 'json', charset: 'utf-8');
  response.write(jsonEncode(requestJson));

  // Read the response
  final httpResponse = await response.close();
  final responseBody = await httpResponse.transform(utf8.decoder).join();

  // Parse and print the response
  final Map<String, dynamic> data = jsonDecode(responseBody);
  // Extract only the main words (descriptions) from the label annotations
  final List<String> mainWords = [];
  final List<dynamic> labelAnnotations = data['responses'][0]['labelAnnotations'];
  for (var annotation in labelAnnotations) {
    final String description = annotation['description'];
    mainWords.add(description);
  }

// Print or store the main words
print(mainWords);


    // // Process the response to extract labels
    // if (response.responses != null && response.responses!.isNotEmpty) {
    //   final labels = response.responses![0].labelAnnotations;
    //   if (labels != null && labels.isNotEmpty) {
    //     // Check if any of the labels match chips, ice cream, or biscuits
    //     final relevantLabels = labels
    //         .where((label) =>
    //             label.description.toLowerCase().contains('chips') ||
    //             label.description.toLowerCase().contains('ice cream') ||
    //             label.description.toLowerCase().contains('biscuits'))
    //         .toList();

    //     if (relevantLabels.isNotEmpty) {
    //       // Image contains chips, ice cream, or biscuits
    //       // Proceed with your logic here
    //     } else {
    //       // Image does not contain chips, ice cream, or biscuits
    //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         content: Text('Image does not contain chips, ice cream, or biscuits.'),
    //       ));
    //     }
    //   } else {
    //     // No labels detected
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text('No labels detected in the image.'),
    //     ));
    //   }
    // } else {
    //   // No response from the Vision API
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //     content: Text('Failed to analyze the image.'),
    //   ));
    // }
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
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         DisplayPictureScreen(imagePath: imagePath),
                    //),
                    //);
                    await _processImage(imagePath);
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

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }

}