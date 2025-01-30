part of 'file_bloc.dart';

class FileState extends Equatable {
  final XFile? studentfile;
  final XFile? teacherfile;

  const FileState({this.studentfile, this.teacherfile});
  FileState copyWith({XFile? student, XFile? teacher}) {
    return FileState(
        studentfile: student ?? this.studentfile,
        teacherfile: teacher ?? this.teacherfile);
  }

  @override
  List<Object?> get props => [studentfile, teacherfile];
}
