// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class beranda extends StatefulWidget {
  const beranda({super.key});

  @override
  State<beranda> createState() => _berandaState();
}
Icon icon1 = Icon(Icons.favorite_border,color: Colors.red,);
    Icon icon2 = Icon(Icons.favorite,color: Colors.red,);
    Icon icon3 = icon1;

class _berandaState extends State<beranda> {
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[400],
        title: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
              // Implement search functionality here
            },
          ),
        ],
      ),
      ),
      body: ListView(
        children: [
          Center(
            child: Stack(
              children: [
                Container(
                  width: 360,
                  height: 660,
                  color: Colors.grey[400],
                ),
                Container(
                  width: 360,
                  height: 660,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          
                          children: [
                            Padding(padding: EdgeInsets.only(top: 200,right: 10)),
                            CircleAvatar(radius: 20,child: Image.asset(""),backgroundColor: Colors.black54,),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            IconButton(onPressed: (){
                              setState(() {
                                if(icon3 == icon1){
                                icon3 = icon2;
                              }
                              else{icon3 = icon1;}
                              });
                              
                            }, icon: icon3,),
                            Text("100"),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 0)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 100)),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("nama akun",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),
                          Padding(padding: EdgeInsets.only(left: 20),child: Text("CAPTION"),),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            children: [
                              Icon(Icons.my_library_music_outlined),
                              Padding(padding: EdgeInsets.only(left: 20),child: Text("nama lagu"),)
                            ],
                          ),
                        )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
