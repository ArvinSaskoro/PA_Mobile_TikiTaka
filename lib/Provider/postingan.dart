import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;
class postinganProvider extends ChangeNotifier{

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
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}