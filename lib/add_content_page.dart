// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir/Provider/user.dart';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:project_akhir/model/Postingan.dart';
import 'package:provider/provider.dart';

import 'Provider/postingan.dart';

class AddContent extends StatefulWidget {
  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _caption = TextEditingController();

  // late DropzoneViewController controller1;
  String message1 = 'Drop your image here';
  bool highlighted1 = false;
  List<html.File> _selectedFiles = [];
  List<String> url = [];
  String judul_lagu = "";
  String url_lagu = "";
  Uint8List? bytes;



  // late List<String> imageUrls;
  // final storage = FirebaseStorage.instance;

  // String fileNameImage = '';
  // String fileNameMusic = '';
  bool isReady = true;

  // postingan post = new postingan();

  // @override
  // void initState() {
  //   super.initState();
  //   imageUrls = [];
  //   getImageUrls();
  // }

  // Future<void> getImageUrls() async {
  //   final ref = storage
  //       .ref()
  //       .child('test'); // Ganti '' dengan nama folder di Firebase Storage Anda
  //   final result = await ref.listAll();

  //   for (var item in result.items) {
  //     final url = await item.getDownloadURL();
  //     setState(() {
  //       imageUrls.add(url);
  //     });
  //   }
  // }

  Future<void> _pickFiles() async {

    final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;
    input.click();

    input.onChange.listen((event) async {
      final files = input.files;
      if (files != null && files.isNotEmpty) {

        setState(() {
          _selectedFiles = List.from(files);
        isReady = judul_lagu.isNotEmpty && _selectedFiles.isNotEmpty;

        });
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
      final ref = FirebaseStorage.instance.ref().child('postingan/gambar/${file.name}');
      await ref.putBlob(blob);

      // Get the download URL
      String downloadUrl = await ref.getDownloadURL();

      url.add(downloadUrl);

      // Use the download URL as needed (store in Firestore, display in app, etc.)
      print('File uploaded: $downloadUrl');
    }
    
  }

  // Future<void> _pickFiles() async {

  //   final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;
  //   input.click();

  //   input.onChange.listen((event) async {
  //     final files = input.files;
  //     if (files != null && files.isNotEmpty) {
  //       setState(() {
  //         _selectedFiles = List.from(files);
  //       });
  //     }
  //   });
  // }



//   Future<void> _uploadImage() async {
//   final html.FileUploadInputElement input = html.FileUploadInputElement()..multiple = true;
//   input.click();

//   input.onChange.listen((event) {
//     final files = input.files;
//     if (files != null && files.isNotEmpty) {
//       final file = files[0];
//       final reader = html.FileReader();

//       reader.onLoadEnd.listen((loadEndEvent) async {
//         // Convert result to Uint8List
//         final Uint8List data = Uint8List.fromList(reader.result as List<int>);
//         String namafile = file.name;

//         // Set state untuk menyimpan nama file
//         setState(() {
//           fileNameImage = namafile;
//           checkReadyState();
//         });

//         // final ref = storage.ref().child('images/$namafile');

//         // await ref.putData(data);

//         // Setelah berhasil mengunggah, muat ulang daftar gambar
//         // getImageUrls();
//         post.setgambar(namafile, data);
//       });

//       reader.readAsArrayBuffer(file);
//     }
//   });
// }
//   Future<void> addMusic(String title, String audioUrl) async {
//     try {
//       await FirebaseFirestore.instance.collection('musics').add({
//         'title': title,
//         'audioUrl': audioUrl,
//       });
//       print('Music added successfully.');
//     } catch (e) {
//       print('Error adding music: $e');
//     }
//   }

  Future<void> _pickMusic() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: false,
      );

      if (result != null) {
        bytes = result.files.single.bytes!;
        judul_lagu = result.files.single.name!; // Gunakan nama file dari properti name
        isReady = judul_lagu.isNotEmpty && _selectedFiles.isNotEmpty;
        print('Audio uploaded successfully and music info added to Firestore.');
      } else {
        // Pengguna membatalkan pemilihan file.
        print('File selection canceled.');
      }
    } catch (e) {
      print('Error picking or uploading audio: $e');
    }
  }

  Future<void> uploadlagu() async {
    Reference storageReference = FirebaseStorage.instance.ref().child('postingan/musil/${judul_lagu}');
    UploadTask uploadTask = storageReference.putData(bytes!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    url_lagu = await taskSnapshot.ref.getDownloadURL();
    // addMusic(namamusik!, audioUrl!);
  }

  // Fungsi untuk memeriksa apakah kedua variabel sudah terisi
//   void checkReadyState() {
//     setState(() {
//      
//     });
//   }

Future<void> _upload() async {
  final post = Provider.of<postinganProvider>(context, listen: false);
    final User = Provider.of<UserProvider>(context, listen: false);
    dynamic urlPoto = await User.getFieldById("path_potoProfile", User.idlogin);
    dynamic userName = await User.getFieldById("username", User.idlogin);


  await _uploadFiles();
  await uploadlagu();
  await post.addPostingan(User.idlogin, url_lagu, _caption.text, 50, url, userName, judul_lagu, urlPoto, _judul.text);
  Navigator.pushNamed(context, '/beranda');
}




  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
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
                controller: _judul,
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
                controller: _caption,
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
                        // await _pickFiles();
                        _pickFiles,
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
                    'File Name:',
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
                    'File Name: ',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: isReady
                      ? _upload
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
