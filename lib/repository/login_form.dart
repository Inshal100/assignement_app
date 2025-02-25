import 'package:assignment_checker/repository/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Extensions extension = Extensions();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Row(
        children: [
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
                    style: GoogleFonts.literata(
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
      width: 320,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(),
      child: TextFormField(
        key: formkey,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: hint),
        focusNode: FocusNode(),
        validator: validation,
      ),
    );
  }
}
