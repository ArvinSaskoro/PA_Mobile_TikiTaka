import 'package:flutter/material.dart';
import 'package:project_akhir/add_content_page.dart';
import 'package:project_akhir/bottomnav.dart';
import 'package:project_akhir/edit_profile_page.dart';
import 'package:project_akhir/introduction_page.dart';
import 'package:project_akhir/other_profile_page.dart';
import 'package:project_akhir/profile_page.dart';
import 'package:project_akhir/searching_page.dart';
import 'package:project_akhir/signin_page.dart';
import 'package:project_akhir/signup_page.dart';
import 'package:project_akhir/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiki Taka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      //home: const SignIn(),
      routes: {
        '/': (context) => SplashScreen(),
        '/introduction': (context) => const IntroductionPage(),
        '/signIn': (context) => const SignIn(),
        '/signUp': (context) => const SignUp(),
        '/addContent': (context) => AddContent(),
        '/search': (context) => const SearchingPage(),
        '/profile': (context) => ProfilePage(),
        '/editProfile': (context) => EditProfilePage(),
        '/otherProfile': (context) => OtherProfilePage(),
        '/bottomnav': (context) => bottomnav(),
      },
      initialRoute: '/',
    );
  }
}

// JUST NOTE for COLOR 

// WARNA TOSCA      29B3AD Color.fromARGB(255, 41, 179, 173)
// WARNA Biru Muda  1D486A Color.fromARGB(255, 29, 72, 106)
// WARNA Biru Tua   122D42 Color.fromARGB(255, 18, 45, 66)
// WARNA Abu cerah  D9D9D9 Color.fromARGB(255, 217, 217, 217)
