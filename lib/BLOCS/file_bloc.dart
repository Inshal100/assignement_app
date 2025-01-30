import 'dart:io';
import 'dart:developer';
import 'package:assignment_checker/repository/filepickerUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  Filepickerutils utils;
  FileBloc(this.utils) : super(FileState()) {
    on<Camera>(_Camerapick);
    on<StudentGallery>(_studentGallery);
    on<TeacherGallery>(_teacherGallery);
    on<LoadModel>(_loadModel);
    on<Compare>(_compare);
  }

  void _studentGallery(FileEvent event, Emitter<FileState> emit) async {
    XFile? file = await utils.GalleryPicker();
    emit(state.copyWith(student: file));
  }

  void _teacherGallery(FileEvent event, Emitter<FileState> emit) async {
    XFile? file = await utils.GalleryPicker();
    emit(state.copyWith(teacher: file));
  }

  void _Camerapick(FileEvent event, Emitter<FileState> emit) async {
    XFile? file = await utils.CameraPicker();
    emit(state.copyWith(student: file));
  }

  void _loadModel(LoadModel event, Emitter<FileState> emit) async {
    if (state.studentfile == null) {
      log("No student file selected");
      return;
    }

    final gemini = Gemini.instance;
    final file = File(state.studentfile!.path);

    try {
      final imageBytes = await file.readAsBytes(); // Asynchronous file reading
      gemini.textAndImage(
        text: "Extract text from the image.",
        images: [imageBytes],
      ).then((value) {
        log(value?.content?.parts?.first.toString() ?? '');
        emit(state.copyWith(
            studentdata:
                value?.content?.parts?.last.toString() ?? "empty picture"));
      }).catchError((e) {
        log('textAndImageInput', error: e);
      });
    } catch (e) {
      log('Error reading file', error: e);
    }
    if (state.studentfile == null) {
      log("No student file selected");
      return;
    }

    final file1 = File(state.teacherfile!.path);

    try {
      final imageBytes1 =
          await file1.readAsBytes(); // Asynchronous file reading
      gemini.textAndImage(
        text: "Extract text from the image.",
        images: [imageBytes1],
      ).then((value) {
        log(value?.content?.parts?.first.toString() ?? '');
        emit(state.copyWith(
            teacherdata:
                value?.content?.parts?.last.toString() ?? "empty picture"));
      }).catchError((e) {
        log('textAndImageInput', error: e);
      });
    } catch (e) {
      log('Error reading file', error: e);
    }
  }

  Future<void> _compare(Compare event, Emitter<FileState> emit) async {
    final gemini = Gemini.instance;

    gemini
        .text(
            "Compare these two texts and give a percenatage how much they are alike.\n Text 1: ${state.student} , Text 2: ${state.teacher}")
        .then((value) {
      emit(state.copyWith(message: value!.output.toString()));
      print(state.message);
      print(state.student.toString());
      print(state.teacher.toString());
    })

        /// or value?.content?.parts?.last.text
        .catchError((e) => print(e.toString()));
  }
}
