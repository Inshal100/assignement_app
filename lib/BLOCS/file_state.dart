part of 'file_bloc.dart';

class FileState extends Equatable {
  final XFile? studentfile;
  final XFile? teacherfile;
  String? student;
  String? teacher;
  String? message;

  FileState(
      {this.studentfile,
      this.teacherfile,
      this.student,
      this.teacher,
      this.message});
  FileState copyWith(
      {XFile? student,
      XFile? teacher,
      String? message,
      String? studentdata,
      String? teacherdata}) {
    return FileState(
        studentfile: student ?? this.studentfile,
        teacherfile: teacher ?? this.teacherfile,
        student: studentdata ?? this.student,
        message: message ?? this.message,
        teacher: teacherdata ?? this.teacher);
  }

  @override
  List<Object?> get props =>
      [studentfile, teacherfile, student, teacher, message];
}
