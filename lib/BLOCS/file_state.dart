part of 'file_bloc.dart';

class FileState extends Equatable {
  final XFile? studentfile;
  final XFile? teacherfile;
  final String? student;
  final String? teacher;
  final String? message;
  final bool isStudentProcessed;
  final bool isTeacherProcessed;

  FileState({
    this.studentfile,
    this.teacherfile,
    this.student,
    this.teacher,
    this.message,
    this.isStudentProcessed = false,
    this.isTeacherProcessed = false,
  });

  FileState copyWith({
    XFile? studentfile,
    XFile? teacherfile,
    String? message,
    String? studentdata,
    String? teacherdata,
    bool? isStudentProcessed,
    bool? isTeacherProcessed,
  }) {
    return FileState(
      studentfile: studentfile ?? this.studentfile,
      teacherfile: teacherfile ?? this.teacherfile,
      student: studentdata ?? this.student,
      teacher: teacherdata ?? this.teacher,
      message: message ?? this.message,
      isStudentProcessed: isStudentProcessed ?? this.isStudentProcessed,
      isTeacherProcessed: isTeacherProcessed ?? this.isTeacherProcessed,
    );
  }

  @override
  List<Object?> get props => [
        studentfile,
        teacherfile,
        student,
        teacher,
        message,
        isStudentProcessed,
        isTeacherProcessed,
      ];
}
