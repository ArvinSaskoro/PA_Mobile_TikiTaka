import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _files = [];

  Future _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result != null) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _files = pickedFiles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: _files.isEmpty
            ? Text('Pilih file dari galeri')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _files.map((file) => Image.file(file)).toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFiles,
        tooltip: 'Pilih File',
        child: Icon(Icons.file_upload),
      ),
    );
  }
}
