// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_akhir/Provider/user.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  // bool signinPressed = false;

  // void navigateToSignUp() {
  //   if (signinPressed) {
  //     Navigator.pushNamed(context, '/signUp[]');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // background atas
            Container(
              height: 260,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 29, 72, 106),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 30),
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Take Your Creativity to the Next Level with Tiki Taka.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Raleway',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            // Username & Password
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              child: TextField(
                controller: _email,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: 'Email',
                  labelStyle: const TextStyle(
                    color: Color.fromARGB(255, 41, 179, 173),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 41, 179, 173),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 41, 179, 173),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              width: double.infinity,
              height: 70,
              // child: Stack(
              //   children: [
              //     SizedBox(
              //       width: 335,
              //       height: 58.98,
              child: TextField(
                controller: _pass,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 41, 179, 173),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 204, 204, 204),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 41, 179, 173),
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 41, 179, 173),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              //    ),
              //  ],
              //),
            ),
            // button bawah
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(0, 50),
                    foregroundColor: Color.fromARGB(255, 18, 45, 66),
                    backgroundColor: Color.fromARGB(255, 29, 72, 106),
                    padding: const EdgeInsets.symmetric(horizontal: 90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    
                   await User.login(_email.value.text, _pass.value.text);
                      print(User.userAuth!.email);
                          if (User.userAuth != null){

                            if(User.userAuth!.email == _email.text){
                             await User.setIDLogin();
                              print(User.idlogin);
                                Navigator.pushNamed(context, "/bottomnav");
                                _email.dispose();
                                _pass.dispose();
                            }       
                          }
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already has an account? ",
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 13,
                    color: Color.fromARGB(255, 18, 45, 66),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontFamily: 'Raleway',
                      color: Color.fromARGB(255, 41, 179, 173),
                      fontSize: 13,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  // onTap: () {
                  //   setState(() {
                  //     signinPressed = !signinPressed;
                  //   });
                  // },
                  // child: Text(
                  //   "Sign Up",
                  //   style: TextStyle(
                  //     fontFamily: 'Raleway',
                  //     color: signinPressed
                  //         ? Color.fromARGB(255, 41, 179, 173)
                  //         : Color.fromARGB(255, 29, 72, 106),
                  //     fontSize: 13,
                  //     decoration: TextDecoration.underline,
                  //   ),
                  // ),
                )
              ],
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
