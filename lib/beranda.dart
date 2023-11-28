import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  List<String> imageUrlList = [];

  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    // Mendapatkan referensi ke direktori di Firebase Storage
    var ref = FirebaseStorage.instance.ref().child('postingan');

    // Mendapatkan daftar file dalam direktori
    var result = await ref.listAll();

    // Mengambil URL masing-masing file dan menyimpannya dalam daftar
    for (var item in result.items) {
      var url = await item.getDownloadURL();
      setState(() {
        imageUrlList.add(url);
      });
    }
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[400],
        title: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Text(
                  "SEARCH",
                  style: TextStyle(color: Colors.black),
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
      body: ListView.builder(
        itemCount: imageUrlList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Stack(
              children: [
                Container(
                  width: lebar,
                  height: tinggi,
                  color: Colors.grey[400],
                  child: Image.network(imageUrlList[index], fit: BoxFit.cover),
                ),
                Container(
                  width: lebar,
                  height: 660,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 200, right: 10)),
                            CircleAvatar(
                              radius: 20,
                              child: Image.asset(""),
                              backgroundColor: Colors.black54,
                            ),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            IconButton(
                              onPressed: () {
                                // Handle like button tap
                                setState(() {
                                  // Toggle between favorite and favorite_border icons
                                  currentIndex = index;
                                });
                              },
                              icon: currentIndex == index
                                  ? Icon(Icons.favorite, color: Colors.red)
                                  : Icon(Icons.favorite_border, color: Colors.red),
                            ),
                            Text("100"),
                          ],
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 0)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(padding: EdgeInsets.only(top: 100)),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "nama akun",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text("CAPTION"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(
                              children: [
                                Icon(Icons.my_library_music_outlined),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Text("nama lagu"),
                                )
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
          );
        },
      ),
    );
  }
}



// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/material.dart';

// class beranda extends StatefulWidget {
//   const beranda({super.key});

//   @override
//   State<beranda> createState() => _berandaState();
// }
//     Icon icon1 = Icon(Icons.favorite_border,color: Colors.red,);
//     Icon icon2 = Icon(Icons.favorite,color: Colors.red,);
//     Icon icon3 = icon1;

// class _berandaState extends State<beranda> {
  
//   @override
//   Widget build(BuildContext context) {
//     var lebar = MediaQuery.of(context).size.width;
//     var tinggi = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.grey[400],
//         title: Row(
//         children: [
//           Expanded( 
//             child: TextButton(onPressed: (){Navigator.pushNamed(context, '/search');}, child:Text("SEARCH",style: TextStyle(color: Colors.black),))
//           ),
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               Navigator.pushNamed(context, '/search');
//               // Implement search functionality here
//             },
//           ),
//         ],
//       ),
//       ),
//       body: ListView(
//         children: [
//           Center(
//             child: Stack(
//               children: [
//                 Container(
//                   width: lebar,
//                   height: tinggi,
//                   color: Colors.grey[400],
//                   //gambar
//                 ),
//                 Container(
//                   width: lebar,
//                   height: 660,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Column(
                          
//                           children: [
//                             Padding(padding: EdgeInsets.only(top: 200,right: 10)),
//                             CircleAvatar(radius: 20,child: Image.asset(""),backgroundColor: Colors.black54,),
//                             Padding(padding: EdgeInsets.only(top: 10)),
//                             IconButton(onPressed: (){
//                               setState(() {
//                                 if(icon3 == icon1){
//                                 icon3 = icon2;
//                               }
//                               else{icon3 = icon1;}
//                               });
                              
//                             }, icon: icon3,),
//                             Text("100"),
//                           ],
//                         ),
//                       ),
//                       Padding(padding: EdgeInsets.only(top: 0)),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Padding(padding: EdgeInsets.only(top: 100)),
//                           Padding(padding: EdgeInsets.only(left: 20),child: Text("nama akun",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),),
//                           Padding(padding: EdgeInsets.only(left: 20),child: Text("CAPTION"),),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 20),
//                           child: Row(
//                             children: [
//                               Icon(Icons.my_library_music_outlined),
//                               Padding(padding: EdgeInsets.only(left: 20),child: Text("nama lagu"),)
//                             ],
//                           ),
//                         )
//                         ],
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
