import 'package:flutter/material.dart';
import 'package:project_akhir/beranda.dart';
import 'package:project_akhir/searching_page.dart';

class bottomnav extends StatefulWidget {
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int currentIndex = 0;
  final List<Widget> _children = [
    beranda(),
    SearchingPage()
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
        backgroundColor: Color.fromARGB(255, 39, 26, 84),
        selectedLabelStyle:
            TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        unselectedLabelStyle:
            TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 35),
        currentIndex: currentIndex,
        onTap: (int index) {
          // setState(() {
          //   currentIndex = index;
          // });
          setState(() {
            currentIndex = index;
            switch (index) {
              case 0:
                Navigator.pushNamed(context, '/beranda');
                break;
              case 1:
                Navigator.pushNamed(context, '/addContent');
                break;
              case 2:
                Navigator.pushNamed(context, '/profile');
                break;
            }
          });
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
