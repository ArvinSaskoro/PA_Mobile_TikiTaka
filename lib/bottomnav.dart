// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_akhir/add_content_page.dart';
import 'package:project_akhir/beranda.dart';
import 'package:project_akhir/profile_page.dart';


class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int currentIndex = 0;
  final List<Widget> _children = [
    Beranda(),
    AddContent(),
    ProfilePage(),
    
    // inputan(),
    // profile(),
  ];
  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 29, 72, 106),
        // selectedLabelStyle:
        //     TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        // unselectedLabelStyle:
        //     TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        fixedColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 217, 217, 217),
        selectedIconTheme: IconThemeData(size: 35),
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
          // setState(() {
          //   currentIndex = index;
          //   switch (index) {
          //     case 0:
          //       Navigator.pushNamed(context, '/beranda');
          //       break;
          //     case 1:
          //       Navigator.pushNamed(context, '/addContent');
          //       break;
          //     case 2:
          //       Navigator.pushNamed(context, '/profile');
          //       break;
          //   }
          // });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Tambah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
