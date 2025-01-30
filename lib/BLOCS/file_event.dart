part of 'file_bloc.dart';

abstract class FileEvent extends Equatable {
  const FileEvent();

  @override
  List<Object> get props => [];
}

class Camera extends FileEvent {}

class StudentGallery extends FileEvent {}

class TeacherGallery extends FileEvent {}

class LoadModel extends FileEvent {}

class Compare extends FileEvent {}
