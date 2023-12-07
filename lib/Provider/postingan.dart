import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:io';

FirebaseFirestore db = FirebaseFirestore.instance;

class postinganProvider extends ChangeNotifier {
  List<File> selectedFiles = [];
  List<String> url = [];
  String judul_lagu = "";
  String url_lagu = "";
  File? bytes;

  Future<void> addPostingan(
    String iduser,
    String urlLagu,
    String caption,
    int jumlaLike,
    List<String> urlpostingan,
    String username,
    String judullagu,
    String urlpoto,
    String judul,
  ) async {
    final CollectionReference postingan = db.collection('postingan');

    try {
      await postingan.add({
        'id_user': iduser,
        'urlLagu': urlLagu,
        'caption': caption,
        'jumlaLike': jumlaLike,
        'urlpostingan': urlpostingan,
        'username': username,
        'judul_lagu': judullagu,
        'URlPotoProfile': urlpoto,
        'judulpostingan': judul,
      });
    } catch (error) {
      print('Error adding postingan: $error');
    }
    notifyListeners();
  }

  void showMessageBox(BuildContext context, String title, String msg) {
    MessageBox msgBox = MessageBox(
      title: title,
      message: msg,
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return msgBox;
      },
    );
  }

  Future<void> uploadFiles() async {
  try {
    final storage = FirebaseStorage.instance;

    for (var file in selectedFiles) {
      if (file != null) {
        String fileName = 'gambar_${DateTime.now().millisecondsSinceEpoch}.jpg';

        Uint8List byteData = await file.readAsBytes();

        Reference storageReference =
            storage.ref().child('postingan/gambar/$fileName');
        await storageReference.putData(byteData);

        String downloadUrl = await storageReference.getDownloadURL();
        url.add(downloadUrl);

        print('File uploaded: $downloadUrl');
      }
    }
  } catch (error) {
    print('Error uploading image: $error');
  }
}

  Future<void> uploadlagu() async {
    try {
      if (bytes != null && judul_lagu.isNotEmpty) {
        String fileName =
            'musik_${DateTime.now().millisecondsSinceEpoch}.mp3';

        Reference storageReference =
            FirebaseStorage.instance.ref().child('postingan/musik/$fileName');

        UploadTask uploadTask = storageReference.putFile(bytes!);

        TaskSnapshot taskSnapshot = await uploadTask;

        url_lagu = await taskSnapshot.ref.getDownloadURL();

        print('Upload successful. Download URL: $url_lagu');
      } else {
        print('Error: bytes is null or judul_lagu is empty');
      }
    } catch (error) {
      print('Error during music upload: $error');
    }
  }

  Future<void> deleteDocumentById(String documentId) async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('postingan').doc(documentId);

      await documentReference.delete();

      print('Document with ID $documentId successfully deleted.');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }
}

class MessageBox extends StatelessWidget {
  final String title;
  final String message;

  MessageBox({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/bottomnav');
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
