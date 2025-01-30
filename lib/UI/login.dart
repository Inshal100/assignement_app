import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Login Screen"),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 50,
              width: 350,
              padding: EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.blueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.purpleAccent),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "Email", border: InputBorder.none),
                focusNode: FocusNode(),
                onChanged: (value) {},
                onFieldSubmitted: (newValue) {},
              ),
            ),
          ),
        ],
      ),
    );
  }
}
