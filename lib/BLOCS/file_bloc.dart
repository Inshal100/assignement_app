import 'dart:io';
import 'dart:developer';
import 'package:assignment_checker/repository/filepickerUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart'; // For text recognition

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  final Filepickerutils utils;
  final textRecognizer =
      GoogleMlKit.vision.textRecognizer(); // Initialize text recognizer

  FileBloc(this.utils) : super(FileState()) {
    on<Camera>(_onCameraPick);
    on<StudentGallery>(_onStudentGallery);
    on<TeacherGallery>(_onTeacherGallery);
    on<LoadModel>(_onLoadModel);
    on<Compare>(_onCompare);
    on<ResetState>(_onResetState);
  }

  Future<void> _onResetState(ResetState event, Emitter<FileState> emit) async {
    // Reset the state to its initial values
    emit(FileState(
      studentfile: null,
      teacherfile: null,
      student: null,
      teacher: null,
      message: null,
      isStudentProcessed: false,
      isTeacherProcessed: false,
    ));
  }

  Future<void> _onStudentGallery(
      StudentGallery event, Emitter<FileState> emit) async {
    final file = await utils.GalleryPicker();
    if (!emit.isDone && file != null) {
      emit(state.copyWith(
        studentfile: file,
        studentdata: null,
        isStudentProcessed: false,
      ));
      add(LoadModel()); // Automatically process the image after selection
    }
  }

  Future<void> _onTeacherGallery(
      TeacherGallery event, Emitter<FileState> emit) async {
    final file = await utils.GalleryPicker();
    if (!emit.isDone && file != null) {
      emit(state.copyWith(
        teacherfile: file,
        teacherdata: null,
        isTeacherProcessed: false,
      ));
      add(LoadModel()); // Automatically process the image after selection
    }
  }

  Future<void> _onCameraPick(Camera event, Emitter<FileState> emit) async {
    final file = await utils.CameraPicker();
    if (!emit.isDone && file != null) {
      emit(state.copyWith(
        studentfile: file,
        studentdata: null,
        isStudentProcessed: false,
      ));
      add(LoadModel()); // Automatically process the image after selection
    }
  }

  Future<void> _onLoadModel(LoadModel event, Emitter<FileState> emit) async {
    // Process student file if available and not processed
    if (state.studentfile != null && !state.isStudentProcessed) {
      try {
        final studentFile = File(state.studentfile!.path);
        final inputImage = InputImage.fromFilePath(studentFile.path);
        final recognizedText = await textRecognizer.processImage(inputImage);

        if (!emit.isDone) {
          emit(state.copyWith(
            studentdata: recognizedText.text,
            isStudentProcessed: true,
          ));
        }
      } catch (e) {
        log('Error processing student file', error: e);
      }
    }
    // Process teacher file if available and not processed
    if (state.teacherfile != null && !state.isTeacherProcessed) {
      try {
        final teacherFile = File(state.teacherfile!.path);
        final inputImage = InputImage.fromFilePath(teacherFile.path);
        final recognizedText = await textRecognizer.processImage(inputImage);

        if (!emit.isDone) {
          emit(state.copyWith(
            teacherdata: recognizedText.text,
            isTeacherProcessed: true,
          ));
        }
      } catch (e) {
        log('Error processing teacher file', error: e);
      }
    }
  }

  Future<void> _onCompare(Compare event, Emitter<FileState> emit) async {
    if (!state.isStudentProcessed || !state.isTeacherProcessed) {
      log("Cannot compare: Images not fully processed");
      if (!emit.isDone) {
        emit(state.copyWith(
          message: "Please wait for both images to be processed",
        ));
      }
      return;
    }

    if (state.student == null || state.teacher == null) {
      log("Cannot compare: missing text data");
      if (!emit.isDone) {
        emit(state.copyWith(
          message: "Error: Could not extract text from both images",
        ));
      }
      return;
    }

    final gemini = Gemini.instance;
    try {
      final result = await gemini.text(
          "Compare these two texts and provide only the similarity percentage in the following exact format: 'Similarity: X%'. "
          "Do not include any additional explanations, descriptions, or text. "
          "Text 1: ${state.student}\n"
          "Text 2: ${state.teacher}");

      if (!emit.isDone) {
        emit(state.copyWith(
          message: result?.output.toString() ?? "Error comparing texts",
        ));
      }
    } catch (e) {
      log('Error during comparison', error: e);
      if (!emit.isDone) {
        emit(state.copyWith(
          message: "Error comparing texts: ${e.toString()}",
        ));
      }
    }
  }

  @override
  Future<void> close() async {
    await textRecognizer.close(); // Dispose of the text recognizer
    super.close();
  }
}
