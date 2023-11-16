import 'package:flutter/material.dart';
import 'package:project_akhir/beranda.dart';

class bottomnav extends StatefulWidget {
  
  const bottomnav({super.key});

  @override
  State<bottomnav> createState() => _bottomnavState();
}

class _bottomnavState extends State<bottomnav> {
  int currentIndex = 0;
  final List<Widget> _children = [
    beranda(),
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
          setState(() {
            currentIndex = index;
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