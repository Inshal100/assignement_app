import 'package:assignment_checker/repository/signup_from.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../repository/login_signup_changer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 82, 82, 83),
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          Center(
            child: Text(
              "Welcome",
              style: GoogleFonts.literata(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                            colors: [Colors.blueGrey, Colors.grey],
                            stops: [0.3, 0.7])
                        .createShader(Rect.fromLTRB(0, 80, 500, 50))),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              height: 500,
              width: 350,
              padding: EdgeInsets.only(top: 25, left: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(23, 174, 162, 0.72),
                      Color.fromRGBO(192, 237, 222, 0.88),
                    ],
                    begin: AlignmentDirectional(
                        -0.26, -0.97), // Approximate for 75°
                    end: AlignmentDirectional(0.97, 0.26),
                  )),
              child: Column(
                children: [
                  Container(
                    color: Colors.red,
                    height: 180,
                    width: 200,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  //LoginTextFields(),
                  SignUpForm()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: ChangerButton()),
        ],
      ),
    );
  }
}
