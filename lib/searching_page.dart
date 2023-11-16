// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage> {
  Widget createButton(String iconName, String text) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, '/otherProfile');
      },
      child: Container(
        width: 300,
        height: 50,
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 18, 45, 66),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            Icon(
              Icons.person_add_alt_rounded,
              color: Colors.white,
            ),
            SizedBox(width: 30),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/bottomnav');
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                height: 35,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 10),
                    Icon(Icons.search),
                  ],
                ),
              ),
              SizedBox(width: 20),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/otherProfile');
                },
                child: Text(
                  "Search",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
        ),
        body: Center(
          child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 45.1),
                  Text(
                    'Profile Recomendation',
                    style: TextStyle(
                      color: Color.fromARGB(255, 18, 45, 66),
                      fontFamily: 'Raleway',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 360,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        createButton("Select Point", "Nama Akun Profil"),
                        createButton("Select Point", "Nama Akun Profil"),
                        createButton("Select Point", "Nama Akun Profil"),
                        createButton("Select Point", "Nama Akun Profil"),
                        createButton("Select Point", "Nama Akun Profil"),
                        createButton("Select Point", "Nama Akun Profil"),
                      ],
                    ),
                  ),
                  // Expanded(
                  //   child: Align(
                  //     alignment: Alignment.bottomCenter,
                  //     child: Stack(
                  //       alignment: Alignment.bottomCenter,
                  //       children: [
                  //         Container(
                  //           height: 180,
                  //           width: double.infinity,
                  //           margin: EdgeInsets.symmetric(horizontal: 40),
                  //           decoration: BoxDecoration(
                  //             color: Color.fromARGB(255, 29, 72, 106),
                  //             borderRadius: BorderRadius.only(
                  //               topLeft: Radius.circular(50),
                  //               topRight: Radius.circular(50),
                  //             ),
                  //           ),
                  //         ),
                  //         // Positioned(
                  //         //   bottom: -150,
                  //         //   left: 0,
                  //         //   right: 0,
                  //         //   child: Image.asset('assets/maskot.png'),
                  //         // ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  Container(
                    height: 180,
                    width: lebar,
                    // color: Colors.blue,
                    child: Stack(
                      children: [
                        Center(
                          
                          child: Positioned(
                            top: 100,
                            // bottom: 0,
                            // right: 0,
                            // left: 0,
                            child: Container(
                              margin: EdgeInsets.only(top: 60),
                              height: 120,
                              width: lebar/1.5,
                              
                              decoration: BoxDecoration(color: Color.fromARGB(255, 29, 72, 106),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),),
                              
                            ),
                          ),
                        ),
                        Center(
                          child: Positioned(
                            // right: 0,
                                // left: 150,
                            
                            child: Image.asset('assets/maskot.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            
          
        ));
  }
}
