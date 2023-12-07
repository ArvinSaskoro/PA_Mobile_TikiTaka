import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tikitaka/model/Postingan.dart';

class Beranda extends StatefulWidget {
  const Beranda({Key? key}) : super(key: key);

  @override
  _BerandaState createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  Postingan post = new Postingan();
  List<String> imageUrlList = [];
  List<String> musicUrlList = [];
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isImageLoaded = false; // Tambahkan variabel ini
  List<bool> isLikedList = [];
   // Ganti 100 sesuai dengan jumlah postingan maksimum (asumsi)


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
      _audioPlayer.setSourceUrl(url);
      musicUrlList.add(url);
    }

    // Tandai bahwa gambar telah di-load setelah daftar imageUrlList terisi
    setState(() {
      isImageLoaded = true;
      isLikedList = List.filled(imageUrlList.length, false);
    });
  }

  void _playMusic() {
    _audioPlayer.play;
  }

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 29, 72, 106),
        elevation: 1,
        title: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/search');
                },
                child: Text(
                  "SEARCH",
                  style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: () {
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('postingan').snapshots(),
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
    var idPostingan = documents[index].id; // Dapatkan ID postingan
    var namaAkun = documents[index]['username'];
    var caption = documents[index]['caption'];
    var namaLagu = documents[index]['judul_lagu'];

    return Center(
      child: Stack(
        children: [
          isImageLoaded
              ? Container(
                  width: lebar,
                  height: tinggi - 120,
                  color: Color.fromARGB(255, 0, 0, 0),
                  child: PageView.builder(
                    itemCount: documents[index]['urlpostingan'].length,
                    itemBuilder: (context, idx) {
                      return Image.network(
                        documents[index]['urlpostingan'][idx],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              : Container(
                  width: lebar,
                  height: tinggi - 120,
                  color: Colors.grey[400],
                  child: Center(
                    child: CircularProgressIndicator(),
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
                          padding: EdgeInsets.only(top: 200, right: 10)),
                      CircleAvatar(
                        radius: 20,
                        child: Image.asset(""),
                        backgroundColor: Colors.black54,
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      IconButton(
                        onPressed: () {
                          // Periksa apakah postingan sudah disukai atau tidak
                          bool isLiked = isLikedList[index];

                          // Perbarui status suka dan simpan ke Firestore
                          FirebaseFirestore.instance
                              .collection('postingan')
                              .doc(idPostingan)
                              .update({'isLiked': !isLiked});

                          setState(() {
                            isLikedList[index] = !isLiked;
                          });
                        },
                        icon: Icon(
                          isLikedList[index]
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: isLikedList[index] ? Colors.red : null,
                        ),
                      ),
                      Text(documents[index]['jumlaLike'].toString()),
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
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(caption ?? ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        children: [
                          Icon(Icons.my_library_music_outlined),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(namaLagu ?? ''),
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
