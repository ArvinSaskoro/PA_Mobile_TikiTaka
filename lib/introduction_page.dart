import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'splash_page.dart';

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
        Navigator.pushNamed(context, '/');
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return SplashScreen();
            },
          ),
        );
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
            "TikiTaka Is A Mobile Video Music Platform Where You Can Express Yourself Through Pictures And Musics With Other People",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset('assets/logo.png'),
        ),
        PageViewModel(
          titleWidget: Text(
            "Interact With Others",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bodyWidget: Text(
            "Discover Other People And Interact With Them Using Our App",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset('assets/nongki.png'),
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
            "Go And Feel It Yourself, Get Started Now And Discover What It Meant To Be You",
            style: TextStyle(
              color: Colors.white, // Ganti warna teks body ke putih di sini
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.asset('assets/img3.png'),
        ),
      ],
    );
  }
}
