// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user.dart';

class EditProfilePage extends StatefulWidget {
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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
  

  @override
  
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    fetchData().then((result) {
        _username.text = result.first;
        _pass.text =result.last;
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
                        // Tambahkan logika untuk memilih foto profil
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // Tambahkan logika untuk kembali ke halaman sebelumnya (ProfilePage)
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
                     if(_pass.text == _conpass.text){
                          if (User.userAuth != null){
                          await users.doc(User.idlogin).update({'username': _username.text, 'pass': _pass.text});
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
