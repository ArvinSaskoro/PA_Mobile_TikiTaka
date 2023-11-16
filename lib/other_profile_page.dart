// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class OtherProfilePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
                    radius: 50,
                    backgroundImage:
                        NetworkImage('https://placekitten.com/100/100'),
                  ),
                  SizedBox(height: 10),
                  Text('Nama Akun',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Text('@username', style: TextStyle(color: Colors.white)),
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
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
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
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Tambahkan logika untuk logout
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
            child: Text(
              'Ini adalah bio profil Anda.',
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
