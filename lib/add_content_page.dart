// ignore_for_file: prefer_const_constructors

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
//import 'dart:html' as html;
import 'dart:typed_data';
// import 'package:project_akhir/model/Postingan.dart';
import 'package:provider/provider.dart';
import 'package:tikitaka/Provider/user.dart';
import 'package:tikitaka/model/Postingan.dart';

import 'Provider/postingan.dart';

class AddContent extends StatefulWidget {
  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _caption = TextEditingController();

  // late List<String> imageUrls;
  // final storage = FirebaseStorage.instance;

  // String fileNameImage = '';
  // String fileNameMusic = '';
  bool isReady = false;
  FilePickerResult? selectedResult;
  FilePickerResult? selectedMusicResult;

  Widget build(BuildContext context) {
    final post = Provider.of<postinganProvider>(context, listen: false);
    void checkReadyState() {
      final post = Provider.of<postinganProvider>(context, listen: false);

      setState(() {
        // isReady = post.judul_lagu.isNotEmpty && post.selectedFiles.isNotEmpty;
      });
    }

    Future<void> _pickFiles() async {
      final post = Provider.of<postinganProvider>(context, listen: false);

      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: true,
        );

        if (result != null) {
          post.selectedFiles = result.files.map((file) => file.bytes!).toList();
          FilePickerResult? selectedResult;

          // post.selectedFiles = List.from(result.files)

          setState(() {});

          checkReadyState();
        } else {
          print('File selection canceled.');
        }
      } catch (e) {
        print('Error picking or uploading images: $e');
      }
    }

    Future<void> _pickMusic() async {
      final post = Provider.of<postinganProvider>(context, listen: false);

      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowMultiple: false,
        );

        if (result != null) {
          post.bytes = result.files.single.bytes!;
          post.judul_lagu =
              result.files.single.name!; // Gunakan nama file dari properti name
          selectedMusicResult = result;
          checkReadyState();
          // isReady = post.judul_lagu.isNotEmpty && post.selectedFiles.isNotEmpty;
          print(
              'Audio uploaded successfully and music info added to Firestore.');
        } else {
          // Pengguna membatalkan pemilihan file.
          print('File selection canceled.');
        }
      } catch (e) {
        print('Error picking or uploading audio: $e');
      }
    }

    Future<void> _upload() async {
      final post = Provider.of<postinganProvider>(context, listen: false);
      final User = Provider.of<UserProvider>(context, listen: false);
      dynamic urlPoto =
          await User.getFieldById("path_potoProfile", User.idlogin);
      dynamic userName = await User.getFieldById("username", User.idlogin);

      await post.uploadFiles();
      await post.uploadlagu();
      await post.addPostingan(User.idlogin, post.url_lagu, _caption.text, 50,
          post.url, userName, post.judul_lagu, urlPoto, _judul.text);
      post.showMessageBox(
          context, 'BERHASIL', 'Postingan anda berhasil di unggah');
      setState(() {
        post.judul_lagu = '';
        // post.selectedFiles= const [];
      });
      // Navigator.pushNamed(context, '/bottomnav');
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
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
                    hintText: 'Your title goes here...',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 18, 45, 66),
                        width: 1.5,
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
                child: TextField(
                  controller: _caption,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Your caption goes here...',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 204, 204, 204),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 18, 45, 66),
                        width: 1.5,
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
              SizedBox(height: 40),
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
                  // Flexible(
                  //   child: Text(
                  //     post.selectedFiles.toString(),
                  //     style: TextStyle(fontSize: 14),
                  //   ),
                  // ),
                  Flexible(
                    child: Text(
                      selectedResult != null
                          ? selectedResult!.files
                              .map((file) => file.name)
                              .join(', ')
                          : 'No files selected',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
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
                      selectedMusicResult != null
                          ? selectedMusicResult!.files.single.name!
                          : 'No music selected',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 70),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          // Aksi untuk tombol "Discard" di sini
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Color.fromARGB(255, 18, 45, 66),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              'Discard',
                              style: TextStyle(
                                color: Color.fromARGB(255, 18, 45, 66),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        onPressed: isReady ? _upload : null,
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
                                    color: Color.fromARGB(255, 18, 45, 66),
                                    width: 1,
                                  ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 5),
                            Text(
                              'Post!',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
