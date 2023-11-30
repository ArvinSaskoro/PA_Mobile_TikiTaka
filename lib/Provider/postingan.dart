import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:typed_data';


FirebaseFirestore db = FirebaseFirestore.instance;
class postinganProvider extends ChangeNotifier{

  List<html.File> selectedFiles = [];
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
      // Disini Anda bisa melakukan operasi lain yang memanfaatkan nilai docID
    } catch (error) {
      print('Error: $error');
    }
      notifyListeners();

  }

  void showMessageBox(BuildContext context) {
  MessageBox msgBox = MessageBox(
    title: "BERHASIL",
    message: "postingan anda berhasil di unggah",
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return msgBox;
    },
  );
}



  Future<void> uploadFiles() async {
    for (var file in selectedFiles) {
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      await reader.onLoadEnd.first;

      final Uint8List data = Uint8List.fromList(reader.result as List<int>);
      final blob = html.Blob([data]);
      final html.File newFile = html.File([data], file.name);

      final ref = FirebaseStorage.instance.ref().child('postingan/gambar/${file.name}');
      await ref.putBlob(blob);

      String downloadUrl = await ref.getDownloadURL();
      url.add(downloadUrl);

      print('File uploaded: $downloadUrl');
    }
    
  }

  Future<void> uploadlagu() async {
    Reference storageReference = FirebaseStorage.instance.ref().child('postingan/musik/${judul_lagu}');
    UploadTask uploadTask = storageReference.putData(bytes!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    url_lagu = await taskSnapshot.ref.getDownloadURL();
    // addMusic(namamusik!, audioUrl!);
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