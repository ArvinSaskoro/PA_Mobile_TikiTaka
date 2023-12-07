// ignore_for_file: prefer_const_constructors

// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';

import 'Provider/user.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  Uint8List? _image;
  String namafile = "";

  TextEditingController _username = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _conpass = TextEditingController();

  Future<List<String>> fetchData() async {
    final User = Provider.of<UserProvider>(context, listen: false);
    // Contoh penundaan untuk mensimulasikan operasi async
    List<String> edit = [];
    edit.add(await User.getFieldById("username", User.idlogin));
    edit.add(await User.getFieldById("pass", User.idlogin));
    return edit;
  }

  Future<void> _uploadImage() async {
    // // final html.InputElement input = html.FileUploadInputElement()..accept = 'image/*';
    // final html.FileUploadInputElement input = html.FileUploadInputElement();
    // input.accept = 'user/*';
    // input.click();

    // input.onChange.listen((event) {
    //   final files = input.files;
    //   if (files != null && files.isNotEmpty) {
    //     final file = files[0];
    //     final reader = html.FileReader();
    //     reader.readAsArrayBuffer(file);
    //     reader.onLoadEnd.listen((loadEndEvent) async {
    //       final Uint8List data = reader.result as Uint8List;
    //       _image = data;
    //       namafile = file.name;
    //       // print(namafile);

    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    fetchData().then((result) {
      _username.text = result.first;
      _pass.text = result.last;
    });

    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference users = db.collection("users");

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 72, 106),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //  _image == null?
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, color: Colors.blue, size: 50),
                      onPressed: () {
                        _uploadImage();
                      },
                    ),
                    // child: Image(image: FileImage(_image!)),
                  )
                  // Container(
                  //   width: 100,
                  //   height: 100,
                  //   decoration: BoxDecoration(

                  //     color: Colors.white,
                  //     shape: BoxShape.circle,
                  //   ),

                  //   child: Image(image: FileImage(_image!)),),
                  //   ElevatedButton(onPressed: (){
                  //     print(_image!);
                  //   }, child: Text("data"))
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _username,
                  decoration: InputDecoration(
                    labelText: 'New Username',
                    hintText: 'Enter your new username',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 41, 179, 173)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 41, 179, 173)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _pass,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter your new password',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 41, 179, 173)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 41, 179, 173)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _conpass,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your new password',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                    labelStyle:
                        TextStyle(color: Color.fromARGB(255, 41, 179, 173)),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 41, 179, 173)),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_pass.text == _conpass.text) {
                      if (User.userAuth != null) {
                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('user/$namafile');
                        await ref.putData(_image!);
                        String downloadUrl = await FirebaseStorage.instance
                            .ref()
                            .child('user/$namafile')
                            .getDownloadURL();
                        print(downloadUrl);
                        await users.doc(User.idlogin).update({
                          'username': _username.text,
                          'pass': _pass.text,
                          'path_potoProfile': downloadUrl
                        });
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: Text('Apply', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(255, 29, 72, 106)),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
