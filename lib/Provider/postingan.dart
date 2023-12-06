import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'dart:io';


FirebaseFirestore db = FirebaseFirestore.instance;
class postinganProvider extends ChangeNotifier{

  // List<html.File> selectedFiles = [];
  List<Uint8List> selectedFiles = [];
  List<String> url = [];
  String judul_lagu = "";
  String url_lagu = "";
  Uint8List? bytes;

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
      DocumentReference doc = await postingan.add({
        'id_user' : iduser,
        'urlLagu' : urlLagu,
        'caption'  : caption,
        'jumlaLike' : jumlaLike,
        'urlpostingan' : urlpostingan,
        'username' : username,
        'judul_lagu' : judullagu,
        'URlPotoProfile' : urlpoto,
        'judulpostingan' : judul,


      });
    } catch (error) {
      print('Error: $error');
    }
      notifyListeners();

  }

  void showMessageBox(BuildContext context, String titlle, String msg) {
  MessageBox msgBox = MessageBox(
    title: titlle,
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

      for (var byteData in selectedFiles) {
        // Convert Uint8List to File
        final file = File.fromRawPath(byteData);

        final ref = storage.ref().child('postingan/gambar/${file.path}');
        await ref.putFile(file);

        String downloadUrl = await ref.getDownloadURL();
        url.add(downloadUrl);

        print('File uploaded: $downloadUrl');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
    
  }

  Future<void> uploadlagu() async {
    Reference storageReference = FirebaseStorage.instance.ref().child('postingan/musik/${judul_lagu}');
    UploadTask uploadTask = storageReference.putData(bytes!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    url_lagu = await taskSnapshot.ref.getDownloadURL();
    // addMusic(namamusik!, audioUrl!);
  }

  Future<void> deleteDocumentById(String documentId) async {
  try {
    // Mendapatkan referensi dokumen berdasarkan ID
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('postingan').doc(documentId);

    // Menghapus dokumen dari Firestore
    await documentReference.delete();

    print('Dokumen dengan ID $documentId berhasil dihapus.');
  } catch (error) {
    print('Error: $error');
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