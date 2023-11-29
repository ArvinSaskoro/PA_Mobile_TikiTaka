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

      });
      // Disini Anda bisa melakukan operasi lain yang memanfaatkan nilai docID
    } catch (error) {
      print('Error: $error');
    }
      notifyListeners();

  }
}