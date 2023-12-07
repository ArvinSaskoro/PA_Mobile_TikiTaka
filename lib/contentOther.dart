import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:tikitaka/Provider/postingan.dart';
import 'package:tikitaka/model/Postingan.dart';

import 'Provider/user.dart';

class ContenOther extends StatefulWidget {
  final String id;
  final bool profile;
  const ContenOther({Key? key, required this.id, required this.profile}) : super(key: key);

  @override
  _ContenOtherState createState() => _ContenOtherState();
}

class _ContenOtherState extends State<ContenOther> {
  List<String> imageUrlList = [];
  List<String> musicUrlList = [];
  AudioPlayer _audioPlayer = AudioPlayer();
  
  


  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    var refGambar = FirebaseStorage.instance.ref().child('postingan/gambar');
    var resultGambar = await refGambar.listAll();

    for (var item in resultGambar.items) {
      var url = await item.getDownloadURL();
      setState(() {
        imageUrlList.add(url);
      });
    }

    var refMusik = FirebaseStorage.instance.ref().child('postingan/musik');
    var resultMusik = await refMusik.listAll();

    for (var item in resultMusik.items) {
      var url = await item.getDownloadURL();
      // _audioPlayer.play(url); // Simpan URL musik
      _audioPlayer.setSourceUrl(url);
      musicUrlList.add(url);
      
    }
  }

  void _playMusic() {
    _audioPlayer.play;
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;
    final User = Provider.of<UserProvider>(context, listen: false);
    final post = Provider.of<postinganProvider>(context, listen: false);



    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed:() {
          if( widget.profile == true){
            Navigator.pushNamed(context, "/bottomnav2");

          }
          else{
            Navigator.pushNamed(context, "/otherProfile");
          }
        }, icon: Icon(Icons.arrow_back, color: Colors.white),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('postingan').where('id_user', isEqualTo: widget.id).snapshots(),
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

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              var namaAkun = documents[index]['username'];
              var caption = documents[index]['caption'];
              var namaLagu = documents[index]['judul_lagu'];

              return Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _audioPlayer.play(UrlSource( documents[index]['urlLagu']));
                      },
                      child: Container(
                        width: lebar,
                        height: tinggi - 120,
                        color: Color.fromARGB(255, 0, 0, 0),
                        child: PageView.builder(
                          itemCount:documents[index]['urlpostingan'].length,
                          itemBuilder: (context,idx) {
                            return Image.network(
                              documents[index]['urlpostingan'][idx],
                              // fit: BoxFit.fill,
                            );
                          }
                        ),
                      ),
                    ),
                    Container(
                      width: lebar,
                      height: tinggi - 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 200, right: 10),
                                ),
                                InkWell(
                                  onTap: () async {
                                    await User.otherProfile(documents[index]['id_user']);
                                    User.searchPage = false;
                                    Navigator.pushNamed(context, "/otherProfile");

                                  },
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Color.fromARGB(136, 145, 145, 145),
                                    backgroundImage: NetworkImage(documents[index]['URlPotoProfile']),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10)),
                                IconButton(
                                  onPressed: () {
                                    // print(documents[index]['urlpostingan'].length);
                                    setState(() {
                                    
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(documents[index]['jumlaLike'].toString(),style: TextStyle(
                                    color: Colors.white,)),
                                // Padding(padding: EdgeInsets.only(top: 10)),
                                 if(widget.profile == true)
                                   IconButton(
                                  onPressed: () async {
                                    await post.deleteDocumentById(documents[index].id);
                                    Navigator.pushNamed(context, '/bottomnav2');

                                    
                                    // print(documents[index]['urlpostingan'].length);
                                    setState(() {
                                      
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )
                                
                               

                                
                          
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
                                  namaAkun ?? '',
                                  style: TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 10),
                                child: Text(caption ?? '',style: TextStyle(
                                    color: Colors.white,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, top: 10),
                                child: Row(
                                  children: [
                                    Icon(Icons.my_library_music_outlined,color: Colors.white,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Text(namaLagu ?? '',style: TextStyle(
                                    color: Colors.white,)),
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
          );
        },
      ),
    );
  }
}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';

// class Beranda extends StatefulWidget {
//   const Beranda({Key? key}) : super(key: key);

//   @override
//   _BerandaState createState() => _BerandaState();
// }

// class _BerandaState extends State<Beranda> {
//   List<String> imageUrlList = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadImageUrls();
//   }

//   Future<void> _loadImageUrls() async {
//     var ref = FirebaseStorage.instance.ref().child('postingan');
//     var result = await ref.listAll();

//     for (var item in result.items) {
//       var url = await item.getDownloadURL();
//       setState(() {
//         imageUrlList.add(url);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var lebar = MediaQuery.of(context).size.width;
//     var tinggi = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         elevation: 1,
//         title: Row(
//           children: [
//             Expanded(
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/search');
//                 },
//                 child: Text(
//                   "SEARCH",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.search),
//               onPressed: () {
//                 Navigator.pushNamed(context, '/search');
//               },
//             ),
//           ],
//         ),
//       ),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance.collection('postingan').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           List<DocumentSnapshot> documents = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               var namaAkun = documents[index]['id_user'];
//               var caption = documents[index]['caption'];
//               var namaLagu = documents[index]['judul_lagu'];

//               return Center(
//                 child: Stack(
//                   children: [
//                     Container(
//                       width: lebar,
//                       height: tinggi - 120,
//                       color: Colors.grey[400],
//                       child: Image.network(
//                         imageUrlList[index],
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       width: lebar,
//                       height: tinggi - 120,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(right: 10),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                     padding:
//                                         EdgeInsets.only(top: 200, right: 10)),
//                                 CircleAvatar(
//                                   radius: 20,
//                                   child: Image.asset(""),
//                                   backgroundColor: Colors.black54,
//                                 ),
//                                 Padding(padding: EdgeInsets.only(top: 10)),
//                                 IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       // Handle like button tap
//                                     });
//                                   },
//                                   icon: Icon(
//                                     Icons.favorite_border,
//                                     color: Colors.red,
//                                   ),
//                                 ),
//                                 Text("100"),
//                               ],
//                             ),
//                           ),
//                           Padding(padding: EdgeInsets.only(top: 0)),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(padding: EdgeInsets.only(top: 100)),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 20),
//                                 child: Text(
//                                   namaAkun ?? '',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 20, top: 10),
//                                 child: Text(caption ?? ''),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20, top: 10),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.my_library_music_outlined),
//                                     Padding(
//                                       padding: EdgeInsets.only(left: 20),
//                                       child: Text(namaLagu ?? ''),
//                                     )
//                                   ],
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
