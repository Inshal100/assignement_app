import 'package:assignment_checker/repository/extensions.dart';
import 'package:assignment_checker/repository/login_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  Extensions extension = Extensions();

  SignUpForm({super.key});

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
              Fields(
                hint: 'Username',
                validation: extension.isUser,
              ),
              SizedBox(
                height: 10,
              ),
              Fields(hint: 'Email', validation: extension.isEmail),
              SizedBox(
                height: 10,
              ),
              Fields(hint: 'Password', validation: extension.isPassword),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "SignUp",
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
