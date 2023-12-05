import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_akhir/Provider/auth.dart';
import 'package:project_akhir/Provider/theme_provider.dart';
import 'package:project_akhir/Provider/user.dart';
import 'package:project_akhir/add_content_page.dart';
import 'package:project_akhir/beranda.dart';
import 'package:project_akhir/bottomnav.dart';
import 'package:project_akhir/edit_profile_page.dart';
import 'package:project_akhir/firebase_options.dart';
import 'package:project_akhir/introduction_page.dart';
import 'package:project_akhir/other_profile_page.dart';
import 'package:project_akhir/profile_page.dart';
import 'package:project_akhir/searching_page.dart';
import 'package:project_akhir/signin_page.dart';
import 'package:project_akhir/signup_page.dart';
import 'package:project_akhir/splash_page.dart';
//import 'package:project_akhir/tes.dart';
import 'package:provider/provider.dart';
import 'Provider/postingan.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => postinganProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
       // Inisialisasi DataProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    return MaterialApp(
      title: 'Tiki Taka',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).getTheme(),
      routes: {
        '/': (context) => SplashScreen(),
        '/introduction': (context) => IntroductionPage(),
        '/signIn': (context) => SignIn(),
        '/signUp': (context) => SignUp(),
        '/beranda': (context) => Beranda(),
        '/addContent': (context) => AddContent(),
        '/search': (context) => SearchingPage(),
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
