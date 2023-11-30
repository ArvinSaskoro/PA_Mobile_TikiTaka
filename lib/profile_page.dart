// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user.dart';
import 'editBio.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);
    String userId = "XqEzdA0TqKQFlQft5WpD";
    // User.setIDLogin();
    

    return Scaffold(
      key: _scaffoldKey,
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
                  SizedBox(height: 20),

            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SizedBox(height: 10,),
                  StreamBuilder<DocumentSnapshot>(
                    stream:  User.users.doc(User.idlogin).snapshots(),
                    builder: (_, snapshot) {
                        return CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage(snapshot.data!.get("path_potoProfile")),
                        );
                      }
                    
                  ),
                  SizedBox(height: 10),
                  StreamBuilder<DocumentSnapshot>(
                    stream:  User.users.doc(User.idlogin).snapshots(),
                    builder: (_, snapshot) {
                      return Text(snapshot.data!.get("username"),
                          style: TextStyle(color: Colors.white, fontSize: 20));
                    }
                  ),
                  StreamBuilder<DocumentSnapshot>(
                    stream:  User.users.doc(User.idlogin).snapshots(),
                    builder: (_, snapshot) {
                      return Text(snapshot.data!.get("email"), style: TextStyle(color: Colors.white));
                    }
                  ),
                  SizedBox(height: 10),

                   GestureDetector(
                    onTap: () {
                      // Tambahkan logika untuk mengedit atau menambah bio
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditBioPage(),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.white, weight: 5,),
                        Text(
                          'Edit Bio',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
           
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Tampilkan drawer settings
                  _scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 29, 72, 106)),
              child: Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {
                // Tambahkan logika untuk navigasi ke halaman edit profil
                Navigator.pushNamed(context, '/editProfile');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Tambahkan logika untuk logout
                Navigator.pushNamed(context, '/signIn');
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Account'),
              onTap: () {
                // Tambahkan logika untuk menghapus akun
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Bagian bio profile Anda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<DocumentSnapshot>(
               stream:  User.users.doc(User.idlogin).snapshots(),
                builder: (_, snapshot) {
                return Text(
                  snapshot.data!.get("bio"),
                  style: TextStyle(fontSize: 18),
                );
              }
            ),
          ),
          // Bagian daftar postingan
          // Expanded(
          //   child: ListView(
          //     children: [
          //       Container(
          //         // Container kosong untuk daftar postingan
          //         height: 200, // Atur tinggi container sesuai kebutuhan
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //         ),
          //         child: Center(
          //           child: Text(
          //             'Daftar Postingan Anda Akan Muncul Di Sini', // Ganti dengan pesan yang sesuai
          //             style: TextStyle(fontSize: 16),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

           Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('postingan')
            .where('id_user', isEqualTo: userId) 
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Anda belum membuat postingan.',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            );
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              dynamic urlPostingan = documents[index]['urlpostingan'];

              if (urlPostingan is List && urlPostingan.isNotEmpty) {
                List<String> imageUrls = List<String>.from(urlPostingan);

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Image.network(
                    imageUrls[0],
                    fit: BoxFit.cover,
                  ),
                );
              } else {
                return Container(); // Handle empty or incorrect data format.
              }
            },
          );
        },
      ),
    ),
        ],
      ),
    );
  }
}
