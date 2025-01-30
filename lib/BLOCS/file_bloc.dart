import 'package:assignment_checker/repository/filepickerUtils.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  Filepickerutils utils;
  FileBloc(this.utils) : super(FileState()) {
    on<Camera>(_Camerapick);
    on<StudentGallery>(_studentGallery);
    on<TeacherGallery>(_teacherGallery);
    on<LoadModel>(loadModel);
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

  void loadModel(LoadModel event, Emitter<FileState> emit) async {
    try {
      // Check if studentfile is null
      if (state.studentfile == null) {
        throw Exception('No image file selected');
      }

      // Load the model
      final interpreter =
          await Interpreter.fromAsset('assets/Models/model.tflite').then(
              (interpreter) =>
                  IsolateInterpreter.create(address: interpreter.address));

      // Prepare inputs
      var inputs =
          await state.studentfile!.readAsBytes(); // Ensure inputs are ready

      // Prepare an empty output tensor list
      var outputs = List.filled(1, List<double>.filled(1000, 0.0));

      // Run the model
      await interpreter.run([inputs], outputs);

      // Handle outputs
      print(outputs); // Handle your output as needed
    } catch (e, stackTrace) {
      // Log the error
      print('Error loading or running model: $e');
      print('Stack trace: $stackTrace');
    }
  }
}
