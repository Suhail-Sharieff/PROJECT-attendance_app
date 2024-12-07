import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';

abstract class StudentDBAbstractProvider{
  Future<void>addStudent(Student newStudent);
  Future<List<Student>>getAllStudents(SortBy how);
  Future<void>updateStudent(Student student);
  Future<void>deleteStudent(Student student);
  Future<List<Map<String,dynamic>>>getStudentAttendanceMapList(Student student);
  Future<bool>isPresentToday(Student student);
  Future<void>markStudent(Student student);
  Future<void>refresh();
}