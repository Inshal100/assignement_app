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
                    'Hi Player \nGood Morning',
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
                    height: 300,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          BlocBuilder<FileBloc, FileState>(
                              buildWhen: (previous, current) => false,
                              builder: (context, state) {
                                return Buttons(
                                  ontap: () {
                                    context
                                        .read<FileBloc>()
                                        .add(StudentGallery());
                                  },
                                  data: 'Student',
                                  path:
                                      'https://cdn-icons-png.flaticon.com/512/10771/10771418.png',
                                );
                              }),
                          SizedBox(
                            width: 30,
                          ),
                          BlocBuilder<FileBloc, FileState>(
                              buildWhen: (previous, current) => false,
                              builder: (context, state) {
                                return Buttons(
                                  ontap: () {
                                    context
                                        .read<FileBloc>()
                                        .add(TeacherGallery());
                                  },
                                  data: 'Teacher',
                                  path:
                                      'https://cdn-icons-png.flaticon.com/512/10771/10771418.png',
                                );
                              })
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<FileBloc, FileState>(
                          buildWhen: (previous, current) {
                        return previous.isStudentProcessed !=
                                current.isStudentProcessed ||
                            previous.isTeacherProcessed !=
                                current.isTeacherProcessed ||
                            previous.message != current.message;
                      }, builder: (context, state) {
                        return Column(
                          children: [
                            // Show processing status
                            if (state.studentfile != null)
                              Text(
                                state.isStudentProcessed
                                    ? "Student image processed "
                                    : "Processing student image...",
                                style: GoogleFonts.abhayaLibre(
                                    color: Colors.white),
                              ),
                            if (state.teacherfile != null)
                              Text(
                                  state.isTeacherProcessed
                                      ? "Teacher image processed "
                                      : "Processing teacher image...",
                                  style: GoogleFonts.abhayaLibre(
                                      color: Colors.white)),

                            Container(
                              child: state.message != null
                                  ? GestureDetector(
                                      onTap: () {
                                        context
                                            .read<FileBloc>()
                                            .add(ResetState());
                                      },
                                      child: RoundButton(
                                        text: state.message.toString(),
                                      ))
                                  : GestureDetector(
                                      onTap: () {
                                        if (state.isStudentProcessed &&
                                            state.isTeacherProcessed) {
                                          context
                                              .read<FileBloc>()
                                              .add(Compare());
                                        }
                                      },
                                      child: RoundButton(
                                        text: 'Compare',
                                      ),
                                    ),
                            )
                          ],
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
