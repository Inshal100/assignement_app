import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangerButton extends StatefulWidget {
  bool login;
  ChangerButton({super.key, this.login = true});

  @override
  State<ChangerButton> createState() => _ChangerButtonState();
}

class _ChangerButtonState extends State<ChangerButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            widget.login = true;
          },
          child: Container(
            height: 60,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Center(
              child: Text(
                'Login',
                style:
                    GoogleFonts.abrilFatface(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
        Container(
          height: 60,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          child: Center(
            child: Text(
              'SignUp',
              style:
                  GoogleFonts.abrilFatface(fontSize: 20, color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
