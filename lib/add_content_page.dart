// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class AddContent extends StatefulWidget {
  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  late DropzoneViewController controller1;
  String message1 = 'Drop your image here';
  bool highlighted1 = false;
  List<html.File> _selectedFiles = [];

  late List<String> imageUrls;
  final storage = FirebaseStorage.instance;

  @override

  void initState() {
    super.initState();
    imageUrls = [];
    getImageUrls();
  }

  Future<void> getImageUrls() async {
    final ref = storage.ref().child('test'); // Ganti '' dengan nama folder di Firebase Storage Anda
    final result = await ref.listAll();

    for (var item in result.items) {
      final url = await item.getDownloadURL();
      setState(() {
        imageUrls.add(url);
      });
    }
  }

  Future<void> _uploadImage() async {
    
    // final html.InputElement input = html.FileUploadInputElement()..accept = 'image/*';
    final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;
    input.click();

    input.onChange.listen((event) {
      final files = input.files;
      if (files != null && files.isNotEmpty) {
        setState(() {
          _selectedFiles = List.from(files);
        });

        // Upload all selected files
        // _uploadFiles();
      }
    });
  }

//   Future<void> addMusic(String title, String artist, String genre, String audioUrl) async {
//   try {
//     await FirebaseFirestore.instance.collection('musics').add({
//       'title': title,
//       'artist': artist,
//       'genre': genre,
//       'audioUrl': audioUrl,
//     });
//     print('Music added successfully.');
//   } catch (e) {
//     print('Error adding music: $e');
//   }
// }
Future<void> addMusic(String title, String audioUrl) async {
  try {
    await FirebaseFirestore.instance.collection('musics').add({
      'title': title,
      'audioUrl': audioUrl,
    });
    print('Music added successfully.');
  } catch (e) {
    print('Error adding music: $e');
  }
}

Future<void> _pickMusic() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result != null) {
      Uint8List bytes = result.files.single.bytes!;
      String fileName = result.files.single.name!; // Gunakan nama file dari properti name

      Reference storageReference = FirebaseStorage.instance.ref().child('musics/$fileName');
      UploadTask uploadTask = storageReference.putData(bytes);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String audioUrl = await taskSnapshot.ref.getDownloadURL();

      await addMusic('Judul Lagu', audioUrl);
      print('Audio uploaded successfully and music info added to Firestore.');
    } else {
      // Pengguna membatalkan pemilihan file.
      print('File selection canceled.');
    }
  } catch (e) {
    print('Error picking or uploading audio: $e');
  }
}


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 45, 66),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: TextField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Caption',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 45, 66),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              //height: 150,
              child: TextField(
                controller: TextEditingController(),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Caption',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: 
                  // print(await controller1.pickFiles(mime: ['assets/jpeg', 'assets/png']));
                  _uploadImage
                ,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: Color.fromARGB(255, 29, 72, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Row(
              children: [
                // Tombol pertama
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: _pickMusic,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      backgroundColor: Color.fromARGB(255, 29, 72, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Add Music',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spacer untuk memberikan ruang di antara tombol
                Spacer(),

                // Tombol kedua
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      backgroundColor: Color.fromARGB(255, 41, 179, 173),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          'Post !',
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 45, 66),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDrop: (ev) async {
            print('Zone 1 drop: ${ev.name}');
            setState(() {
              message1 = '${ev.name} dropped';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(ev);
            print(bytes.sublist(0, 20));
          },
          onDropInvalid: (ev) => print('Zone 1 invalid MIME: $ev'),
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      );
}
