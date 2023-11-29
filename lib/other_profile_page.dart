// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user.dart';

class OtherProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
      final User = Provider.of<UserProvider>(context, listen: false);

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
                  Text(User.userSearch.email, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
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
            child: ListView(
              children: [
                Container(
                  // Container kosong untuk daftar postingan
                  height: 200, // Atur tinggi container sesuai kebutuhan
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Daftar Postingan Anda Akan Muncul Di Sini', // Ganti dengan pesan yang sesuai
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
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
