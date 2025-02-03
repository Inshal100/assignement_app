import 'package:assignment_checker/BLOCS/file_bloc.dart';
import 'package:assignment_checker/repository/background.dart';
import 'package:assignment_checker/repository/buttons.dart';
import 'package:assignment_checker/repository/filepickerUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? message;
  late FileBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = FileBloc(Filepickerutils());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc)],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            BackgroundScreen(),
            Container(
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Hi User \nGood Morning',
                    style: GoogleFonts.inter(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                                  colors: [
                                Colors.transparent.withOpacity(0.6),
                                Colors.white
                              ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)
                              .createShader(Rect.fromLTWH(0, 100, 100, 60))),
                  ),
                  SizedBox(
                    height: 280, //280
                  ),
                  // Row(
                  //   children: [
                  //     BlocBuilder<FileBloc, FileState>(
                  //   builder: (context, state) {
                  //     return Container(
                  //       height: 100,
                  //       width: 100,
                  //       child: Text(state.student.toString() ?? "Empty"),
                  //     );
                  //   },
                  // ),
                  // BlocBuilder<FileBloc, FileState>(
                  //   builder: (context, state) {
                  //     return Container(
                  //       height: 100,
                  //       width: 100,
                  //       child: Text(state.teacher.toString() ?? "Empty"),
                  //     );
                  //   },
                  // ),
                  //   ],
                  // )
                  // ,
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              BlocBuilder<FileBloc, FileState>(
                                  buildWhen: (previous, current) => false,
                                  builder: (context, state) {
                                    print("Building button student");
                                    return Buttons(
                                      ontap: () {
                                        context
                                            .read<FileBloc>()
                                            .add(StudentGallery());
                                      },
                                      data: 'Student',
                                      path: 'assets/images/icons2.png',
                                    );
                                  }),
                              BlocBuilder<FileBloc, FileState>(
                                buildWhen: (previous, current) {
                                  return previous.isStudentProcessed !=
                                      current.isStudentProcessed;
                                },
                                builder: (context, state) {
                                  return (state.studentfile != null)
                                      ? Text(
                                          state.isStudentProcessed
                                              ? "Student image processed "
                                              : "Processing student image...",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white),
                                        )
                                      : Container();
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              BlocBuilder<FileBloc, FileState>(
                                  buildWhen: (previous, current) => false,
                                  builder: (context, state) {
                                    print("Building button student");
                                    return Buttons(
                                      ontap: () {
                                        context
                                            .read<FileBloc>()
                                            .add(TeacherGallery());
                                      },
                                      data: 'Teacher',
                                      path: 'assets/images/icons2.png',
                                    );
                                  }),
                              BlocBuilder<FileBloc, FileState>(
                                buildWhen: (previous, current) {
                                  return previous.isTeacherProcessed !=
                                      current.isTeacherProcessed;
                                },
                                builder: (context, state) {
                                  return (state.teacherfile != null)
                                      ? Text(
                                          state.isTeacherProcessed
                                              ? "Teacher image processed "
                                              : "Processing teacher image...",
                                          style: GoogleFonts.abhayaLibre(
                                              color: Colors.white))
                                      : Container();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<FileBloc, FileState>(
                          buildWhen: (previous, current) {
                        return previous.message != current.message;
                      }, builder: (context, state) {
                        print("Building Column up to the button");
                        return Container(
                          child: GestureDetector(
                              onTap: () {
                                if (state.message != null) {
                                  context.read<FileBloc>().add(ResetState());
                                } else {
                                  context.read<FileBloc>().add(Compare());
                                }
                              },
                              child: BlocBuilder<FileBloc, FileState>(
                                buildWhen: (previous, current) {
                                  return previous.s_state != current.s_state;
                                },
                                builder: (context, state) {
                                  print("Building text in the button");
                                  return RoundButton(
                                    s_state: state.s_state,
                                    text: state.message != null
                                        ? state.message.toString()
                                        : 'Compare',
                                  );
                                },
                              )),
                        );
                      })
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
