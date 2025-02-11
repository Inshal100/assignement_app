import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class ChangerButton extends StatelessWidget {
  bool login;
  GestureTapCallback onTap;
  ChangerButton({super.key, required this.login, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                    color: login ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Center(
                  child: Text(
                    'Login',
                    style: GoogleFonts.notoSans(
                        fontSize: 20,
                        color: login ? Colors.white : Colors.black),
                  ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                    color: login ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                  child: Text(
                    'SignUp',
                    style: GoogleFonts.notoSans(
                        fontSize: 20,
                        color: login ? Colors.black : Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
