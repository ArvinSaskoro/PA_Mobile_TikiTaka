import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


FirebaseAuth _fireAuth = FirebaseAuth.instance;
FirebaseFirestore db = FirebaseFirestore.instance;
class UserProvider extends ChangeNotifier{
  User? userAuth = null;
  
  CollectionReference users = db.collection("users");
  String _idLogin = '';
String get idlogin => _idLogin;



Future<dynamic> getFieldById(String fieldName, String id) async {
  try {
    // Mendapatkan referensi dokumen dengan ID tertentu
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('users').doc(id).get();

    // Memeriksa apakah dokumen ditemukan
    if (documentSnapshot.exists) {
      // Mendapatkan data dari dokumen
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

      // Mendapatkan nilai field tertentu
      dynamic fieldValue = data[fieldName];

      // Mengembalikan nilai field
      return data[fieldName];
    } else {
      // Dokumen tidak ditemukan, bisa mengembalikan nilai default atau null sesuai kebutuhan
      return '';
    }
  } catch (e) {
    // Menangani error, bisa mengembalikan nilai default atau null sesuai kebutuhan
    return '';
  }
}


Future<void> signOut() async {
  if(userAuth != null){
     FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signOut();

      // Setelah logout, Anda bisa mengosongkan variabel yang menyimpan data pengguna.
      User? currentUser = _auth.currentUser;
      currentUser = null;
  }
    
  }

Future<void> setIDLogin() async {
    await users
    .where('email', isEqualTo: userAuth!.email)
    .get()
    .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Loop melalui hasil query untuk mendapatkan ID dari dokumen yang cocok
        querySnapshot.docs.forEach((doc) {
          _idLogin = doc.id;
          print("ini adalah id login: "+_idLogin);
          print(userAuth!.email);
        });
      } else {
        print('No documents found with the specified field value');
      }
    })
    .catchError((error) {
      print('Error searching for documents: $error');
    });
    notifyListeners();
}


  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userAuth = _fireAuth.currentUser;
      return userCredential.user;

    } catch (e) {
      print(e);
      return null;
    }
  }

  Future login(String email, String password) async {
    try {
      UserCredential userCredential = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userAuth = _fireAuth.currentUser;
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

 
Future<void> AddUserToFirebase(String username, String email, String pass) async {
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  try {
    DocumentReference doc = await users.add({
      'username' : username,
      'email' : email,
      'pass'  : pass,
      'bio' : "",
      'path_potoProfile' : ""
    });
    // Disini Anda bisa melakukan operasi lain yang memanfaatkan nilai docID
  } catch (error) {
    print('Error: $error');
  }
    notifyListeners();

}


}

