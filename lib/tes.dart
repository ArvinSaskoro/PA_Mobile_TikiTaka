// // import 'dart:js';
// import 'dart:typed_data';
// import 'dart:html' as html;
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:provider/provider.dart';

// import 'Provider/postingan.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MultipleImageUploadPage(),
//     );
//   }
// }

// class MultipleImageUploadPage extends StatefulWidget {

//   @override
//   _MultipleImageUploadPageState createState() => _MultipleImageUploadPageState();
// }

// class _MultipleImageUploadPageState extends State<MultipleImageUploadPage> {
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Multiple File Upload'),
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: _pickFiles,
//             child: Text('Pick Files'),
//           ),
//           SizedBox(height: 20),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _selectedFiles.length,
//               itemBuilder: (context, index) {
//                 return Text(_selectedFiles[index].name);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // void main() {
// //   runApp(MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       home: ImageSlider(),
// //     );
// //   }
// // }

// // class ImageSlider extends StatelessWidget {
// //   final List<String> imageUrls = [
// //     'https://example.com/image1.jpg',
// //     'https://example.com/image2.jpg',
// //     'https://example.com/image3.jpg',
// //     // Tambahkan URL gambar lainnya
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Image Slider'),
// //       ),
// //       body: PageView.builder(
// //         itemCount: imageUrls.length,
// //         itemBuilder: (context, index) {
// //           return Image.network(
// //             imageUrls[index],
// //             fit: BoxFit.cover,
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }


import 'package:flutter/material.dart';

// class Tess {
  void testing() {
  String mainString = "toyota allion 260 2010";
  String substring = "allion";

  bool containsSubstring = mainString.contains(substring);

  print(containsSubstring);
  
  String tes = "toyota allion 260 2010";
  String tess = "to";

  bool hmm = tes.contains(tess);

  print(hmm); // Output: true if contains, false otherwise
}
// Output: true if contains, false otherwise
// }

class tessW extends StatelessWidget {
  const tessW({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(onPressed:() {
        testing();
        
      }, child: Text("data")),
    );
  }
}

