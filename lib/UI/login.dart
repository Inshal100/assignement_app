import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:assignment_checker/BLOCS/Login/login_bloc.dart';
import 'package:assignment_checker/repository/login_form.dart';
import 'package:assignment_checker/repository/signup_from.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../repository/login_signup_changer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc _loginBloc;
  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 82, 82, 83),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
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
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          return Container(
                            height: 180,
                            width: 200,
                            child: state.loginState
                                ? Lottie.asset('assets/Lottie/Login.json')
                                : Lottie.asset('assets/Lottie/Signup.json'),
                          );
                        },
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      BlocBuilder<LoginBloc, LoginState>(
                        buildWhen: (previous, current) {
                          return previous.loginState != current.loginState;
                        },
                        builder: (context, state) {
                          return AnimatedSwitcherPlus.translationBottom(
                            duration: Duration(milliseconds: 300),
                            child:
                                state.loginState ? LoginForm() : SignUpForm(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                  child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) {
                  return current.loginState != previous.loginState;
                },
                builder: (context, state) {
                  return ChangerButton(
                    login: state.loginState,
                    onTap: () {
                      context.read<LoginBloc>().add(ChangeMethod());
                    },
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
