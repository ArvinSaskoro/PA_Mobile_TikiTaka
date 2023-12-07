import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'splash_page.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return IntroductionScreen(
      globalBackgroundColor: Color.fromARGB(255, 29, 72, 106),
      next: Text(
        "Selanjutnya",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      done: Text(
        "Selesai",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      onDone: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, '/');
        Navigator.pushNamed(context, '/splash');
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return SplashScreen();
        //     },
        //   ),
        // );
      },
      pages: [
        PageViewModel(
          titleWidget: Text(
            "Welcome To TikiTaka",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.width * 0.06,
            ),
          ),
          bodyWidget: Text(
            "TikiTaka Is A Mobile Video Music Platform Where You Can Express Yourself Through Pictures And Musics With Other People",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.network(
            "https://picsum.photos/800/500",
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "Interact With Others",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.width * 0.06,
            ),
          ),
          bodyWidget: Text(
            "Discover Other People And Interact With Them Using Our App",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.network(
            "https://picsum.photos/800/600",
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            "What Are You Waiting?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: size.width * 0.06,
            ),
          ),
          bodyWidget: Text(
            "Go And Feel It Yourself, Get Started Now And Discover What It Meant To Be You",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          image: Image.network(
            "https://picsum.photos/900/700",
            width: size.width * 0.8,
            height: size.height * 0.4,
          ),
        ),
      ],
    );
  }
}
