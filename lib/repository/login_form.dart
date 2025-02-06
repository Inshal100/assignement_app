import 'package:assignment_checker/repository/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class LoginTextFields extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Extensions extension = Extensions();

  LoginTextFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
          SizedBox(
            width: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Fields(hint: 'Email', validation: extension.isEmail),
              SizedBox(
                height: 20,
              ),
              Fields(hint: 'Password', validation: extension.isPassword),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Login",
                    style: GoogleFonts.abel(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ],
      ),
    );
  }
}

class Fields extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final String hint;
  final String? Function(String?) validation;
  Fields({super.key, required this.hint, required this.validation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      padding: EdgeInsets.all(10),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 6)
          ],
          border: GradientBoxBorder(
            gradient: LinearGradient(colors: [
              Colors.grey,
              Colors.black.withOpacity(0.4),
              Colors.grey,
              Colors.black.withOpacity(0.4)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(40),
          color: Colors.white),
      child: TextFormField(
        key: formkey,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        focusNode: FocusNode(),
        validator: validation,
      ),
    );
  }
}

class ChangerButton extends StatefulWidget {
  const ChangerButton({super.key});

  @override
  State<ChangerButton> createState() => _ChangerButtonState();
}

class _ChangerButtonState extends State<ChangerButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
