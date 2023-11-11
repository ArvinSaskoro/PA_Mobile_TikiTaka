// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Color.fromARGB(255, 29, 72, 106),
      next: Text("Selanjutnya"),
      done: Text("Selesai"),
      onDone: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/signIn');
      },
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Welcome To TikiTaka",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bodyWidget: Text(
            "A Place Where You Can Express Yourself",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          image: Image.network("https://picsum.photos/800/500"),
        ),
        PageViewModel(
          titleWidget: Text(
            "Find Yourself",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bodyWidget: Text(
            "Discover What It Means To Be Yourself",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          image: Image.network("https://picsum.photos/800/600"),
        ),
        PageViewModel(
          titleWidget: Text(
            "What Are You Waiting?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // Ganti warna teks title ke putih di sini
            ),
          ),
          bodyWidget: Text(
            "Go And Feel It Yourself",
            style: TextStyle(
              color: Colors.white, // Ganti warna teks body ke putih di sini
            ),
          ),
          image: Image.network("https://picsum.photos/900/700"),
        ),
      ],
    );
  }
}
