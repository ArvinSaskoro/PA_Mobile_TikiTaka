// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';

class AddContent extends StatefulWidget {
  @override
  State<AddContent> createState() => _AddContentState();
}

class _AddContentState extends State<AddContent> {
  late DropzoneViewController controller1;

  String message1 = 'Drop your image here';

  bool highlighted1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //title: Text('Add Content', style: TextStyle(color: Colors.black)),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Color.fromARGB(255, 29, 72, 106),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {
                // Tambahkan logika untuk navigasi ke halaman beranda
                Navigator.pushNamed(context, '/beranda');
              },
            ),
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white),
              onPressed: () {
                // Tambahkan logika untuk menambahkan postingan
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle, color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Title',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 45, 66),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 50,
              child: TextField(
                controller: TextEditingController(),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Caption',
              style: TextStyle(
                color: Color.fromARGB(255, 18, 45, 66),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              //height: 150,
              child: TextField(
                controller: TextEditingController(),
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Caption',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 18, 45, 66),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                onPressed: () async {
                  // print(await controller1
                  //     .pickFiles(mime: ['assets/jpeg', 'assets/png']));
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: Color.fromARGB(255, 29, 72, 106),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromARGB(255, 18, 45, 66),
                  ),
                  color: highlighted1
                      ? Colors.red
                      : Color.fromARGB(255, 217, 217, 217),
                ),
                child: Stack(
                  children: [
                    buildZone1(context),
                    Center(child: Text(message1)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                // Tombol pertama
                SizedBox(
                  width: 140,
                  child: ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      backgroundColor: Color.fromARGB(255, 29, 72, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_circle, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Add Music',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),

                // Spacer untuk memberikan ruang di antara tombol
                Spacer(),

                // Tombol kedua
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20),
                      backgroundColor: Color.fromARGB(255, 41, 179, 173),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 5),
                        Text(
                          'Post !',
                          style: TextStyle(
                            color: Color.fromARGB(255, 18, 45, 66), 
                            fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildZone1(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => controller1 = ctrl,
          onLoaded: () => print('Zone 1 loaded'),
          onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlighted1 = true);
            print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlighted1 = false);
            print('Zone 1 left');
          },
          onDrop: (ev) async {
            print('Zone 1 drop: ${ev.name}');
            setState(() {
              message1 = '${ev.name} dropped';
              highlighted1 = false;
            });
            final bytes = await controller1.getFileData(ev);
            print(bytes.sublist(0, 20));
          },
          onDropInvalid: (ev) => print('Zone 1 invalid MIME: $ev'),
          onDropMultiple: (ev) async {
            print('Zone 1 drop multiple: $ev');
          },
        ),
      );
}
