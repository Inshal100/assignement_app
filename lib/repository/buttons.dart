import 'package:assignment_checker/repository/Loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Buttons extends StatelessWidget {
  final String data;
  final String path;
  final Function ontap;
  const Buttons(
      {super.key, required this.data, required this.path, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap(),
      child: Container(
        height: 120,
        width: 160,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
                radius: 30,
                child: ClipOval(child: Image.asset(path.toString()))),
            SizedBox(
              height: 10,
            ),
            Text(data.toString(),
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final String text;
  final SimilarityState s_state;
  const RoundButton({super.key, required this.text, required this.s_state});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.purple.withOpacity(0.5),
                  blurRadius: 5,
                  offset: Offset(0, 0),
                  spreadRadius: 3.5)
            ],
            gradient: LinearGradient(colors: [
              Colors.purple.withOpacity(0.4),
              Colors.blueAccent.withOpacity(0.4)
            ], stops: [
              0.2,
              0.8
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(30),
            border: GradientBoxBorder(
                width: 3,
                gradient: LinearGradient(
                    colors: [Colors.purple, Colors.blueAccent],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter))),
        child: Center(
            child: s_state == SimilarityState.loading
                ? LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.purpleAccent,
                    size: 100,
                  )
                : Text(text.toString(),
                    style: GoogleFonts.abhayaLibre(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white))));
  }
}
