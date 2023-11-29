import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultipleImageUploadPage(),
    );
  }
}

class MultipleImageUploadPage extends StatefulWidget {
  @override
  _MultipleImageUploadPageState createState() => _MultipleImageUploadPageState();
}

class _MultipleImageUploadPageState extends State<MultipleImageUploadPage> {
  List<html.File> _selectedFiles = [];

  Future<void> _pickFiles() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;
    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        setState(() {
          _selectedFiles = List.from(files);
        });

        // Upload all selected files
        _uploadFiles();
      }
    });
  }

  Future<void> _uploadFiles() async {
    for (var file in _selectedFiles) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      await reader.onLoadEnd.first;

      // Convert result to Uint8List
      final Uint8List data = Uint8List.fromList(reader.result as List<int>);

      // Create a File object from Uint8List data
      final blob = html.Blob([data]);
      final html.File newFile = html.File([data], file.name);

      // Upload the file to Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('images/${file.name}');
      await ref.putBlob(blob);

      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();

      // Use the download URL as needed (store in Firestore, display in app, etc.)
      print('File uploaded: $downloadUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multiple File Upload'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickFiles,
            child: Text('Pick Files'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _selectedFiles.length,
              itemBuilder: (context, index) {
                return Text(_selectedFiles[index].name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
