import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tikitaka/Provider/auth.dart';
import 'package:tikitaka/Provider/user.dart';
import 'package:tikitaka/add_content_page.dart';
import 'package:tikitaka/beranda.dart';
import 'package:tikitaka/bottomnav.dart';
import 'package:tikitaka/edit_profile_page.dart';
import 'package:tikitaka/firebase_options.dart';
import 'package:tikitaka/introduction_page.dart';
import 'package:tikitaka/other_profile_page.dart';
import 'package:tikitaka/profile_page.dart';
import 'package:tikitaka/searching_page.dart';
import 'package:tikitaka/signin_page.dart';
import 'package:tikitaka/signup_page.dart';
import 'package:tikitaka/splash_page.dart';
import 'package:tikitaka/tes.dart';
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
    // User.setIDLogin();

    return MaterialApp(
      title: 'Tiki Taka',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      //home: const SignIn(), 
      routes: {
        // '/': (context) => ImageSlider(),
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
        // '/tes': (context) => ImageSlider(),

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
