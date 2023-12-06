// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/postingan.dart';
import 'Provider/user.dart';

class OtherProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);
    final post = Provider.of<postinganProvider>(context, listen: false);

    String userId = User.userSearch.id;

    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
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
                  CircleAvatar(
                    radius: 45,
                    backgroundImage:
                        NetworkImage(User.userSearch.path_potoProfile),
                  ),
                  SizedBox(height: 10),
                  Text(User.userSearch.username,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text(User.userSearch.email,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  if (User.searchPage == false) {
                    Navigator.pushNamed(context, '/bottomnav');
                    User.userSearch.id = "";
                    User.userSearch.bio = "";
                    User.userSearch.email = "";
                    User.userSearch.username = "";
                    User.userSearch.path_potoProfile = "";
                  } else {
                    Navigator.pushNamed(context, '/search');
                    User.userSearch.id = "";
                    User.userSearch.bio = "";
                    User.userSearch.email = "";
                    User.userSearch.username = "";
                    User.userSearch.path_potoProfile = "";
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Bagian bio profile Anda
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              User.userSearch.bio,
              style: TextStyle(fontSize: 18),
            ),
          ),
          // Bagian daftar postingan
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('postingan')
                  .where('id_user', isEqualTo: userId)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
      // bottomNavigationBar: BottomAppBar(
      //   height: 60,
      //   color: Color.fromARGB(255, 29, 72, 106),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.home, color: Colors.white),
      //         onPressed: () {
      //           // Tambahkan logika untuk navigasi ke halaman beranda
      //           Navigator.pushNamed(context, '/beranda');
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.add_circle, color: Colors.white),
      //         onPressed: () {
      //           // Tambahkan logika untuk menambahkan postingan
      //           Navigator.pushNamed(context, '/addContent');
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.account_circle, color: Colors.white),
      //         onPressed: () {
      //           Navigator.pushNamed(context, '/profile');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
