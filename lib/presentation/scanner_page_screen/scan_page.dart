import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProductScanner extends StatefulWidget {
  @override
  _ProductScannerState createState() => _ProductScannerState();
}

class _ProductScannerState extends State<ProductScanner> {
  XFile? _image; // Use XFile instead of File
  String _productInfo = '';

  Future<void> _getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = image;
      });
      _recognizeProduct(_image!);
    }
  }

  Future<void> _recognizeProduct(XFile image) async {
    Uint8List imageBytes = await image.readAsBytes();
    String base64Image = base64Encode(imageBytes);

    try {
      final response = await http.post(
        Uri.parse('https://vision.googleapis.com/v1/images:annotate?key='),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'requests': [
            {
              'image': {
                'content': base64Image,
              },
              'features': [
                {'type': 'LABEL_DETECTION', 'maxResults': 10},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        // Extract product information from response
        var decodedResponse = jsonDecode(response.body);
        // TODO: Match the response with your database to retrieve product information
        // For simplicity, just displaying the response as is
        setState(() {
          _productInfo = decodedResponse.toString();
        });
      } else {
        throw Exception('Failed to recognize product');
      }
    } catch (e) {
      setState(() {
        _productInfo = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null
                ? Text('No image selected.')
                : Image.file(File(_image!.path)), // Convert XFile to File for displaying
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Take Picture'),
            ),
            SizedBox(height: 20),
            Text(_productInfo),
          ],
        ),
      ),
    );
  }
}
