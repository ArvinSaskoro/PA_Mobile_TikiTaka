// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';

class AddContent extends StatefulWidget {
  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
<<<<<<< HEAD
  late DropzoneViewController controller1;
  String message1 = 'Drop your image here';
  bool highlighted1 = false;
  List<html.File> _selectedFiles = [];

=======
>>>>>>> 3e8cc2d636c05234aabcb1097ac469eb8aa70554
  late List<String> imageUrls;
  final storage = FirebaseStorage.instance;

  String fileNameImage = '';
  String fileNameMusic = '';
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    imageUrls = [];
    getImageUrls();
  }

  Future<void> getImageUrls() async {
    final ref = storage
        .ref()
        .child('test'); // Ganti '' dengan nama folder di Firebase Storage Anda
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
<<<<<<< HEAD
        setState(() {
          _selectedFiles = List.from(files);
=======
        final file = files[0];
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((loadEndEvent) async {
          final Uint8List data = reader.result as Uint8List;
          String namafile = file.name;

          // Set state untuk menyimpan nama file
          setState(() {
            fileNameImage = namafile;
            checkReadyState();
          });

          final ref = storage.ref().child('images/$namafile');

          await ref.putData(data);

          // Setelah berhasil mengunggah, muat ulang daftar gambar
          getImageUrls();
>>>>>>> 3e8cc2d636c05234aabcb1097ac469eb8aa70554
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
        String fileName =
            result.files.single.name!; // Gunakan nama file dari properti name

        Reference storageReference =
            FirebaseStorage.instance.ref().child('musics/$fileName');
        UploadTask uploadTask = storageReference.putData(bytes);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String audioUrl = await taskSnapshot.ref.getDownloadURL();

        // Set state untuk menyimpan nama file musik
        setState(() {
          fileNameMusic = fileName;
          checkReadyState();
        });

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

  // Fungsi untuk memeriksa apakah kedua variabel sudah terisi
  void checkReadyState() {
    setState(() {
      isReady = fileNameImage.isNotEmpty && fileNameMusic.isNotEmpty;
    });
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
            SizedBox(height: 20),

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
            SizedBox(height: 50),
            Row(
              children: [
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed:
                        // print(await controller1.pickFiles(mime: ['assets/jpeg', 'assets/png']));
                        _uploadImage,
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
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'File Name: $fileNameImage',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(height: 10),
            SizedBox(height: 20),
            //   Expanded(
            //   child: ListView.builder(
            //     itemCount: imageUrls.length,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Image.network(imageUrls[index]),
            //       );
            //     },
            //   ),
            // ),
            
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
                SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'File Name: $fileNameMusic',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 100),
            Center(
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: isReady
                      ? () async {}
                      : null, // nonaktifkan tombol jika belum terisi
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    backgroundColor: isReady
                        ? Color.fromARGB(255, 29, 72, 106)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: isReady
                          ? BorderSide.none
                          : BorderSide(
                              color: Color.fromARGB(255, 18, 45, 66), width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'Post !',
                        style: TextStyle(
                          color: isReady
                              ? Colors.white
                              : Color.fromARGB(255, 29, 72, 106),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
