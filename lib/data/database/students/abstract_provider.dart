import 'package:attendance_app/data/models/student_model/student_model.dart';

abstract class StudentDBAbstractProvider{
  Future<void>addStudent(Student newStudent);
  Future<List<Student>>getAllStudents();
  Future<void>updateStudent(Student student);
  Future<void>deleteStudent(Student student);
}