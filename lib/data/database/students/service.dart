import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/provider.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';

class StudentDBService implements StudentDBAbstractProvider{
  final instance=StudentDBProvider();

  @override
  Future<void> addStudent(Student newStudent) =>instance.addStudent(newStudent);

  @override
  Future<void> deleteStudent(Student student) =>instance.deleteStudent(student);

  @override
  Future<List<Student>> getAllStudents(SortBy how) =>instance.getAllStudents(how);

  @override
  Future<void> updateStudent(Student student) =>instance.updateStudent(student);

  @override
  Future<void> markStudent(Student student) =>instance.markStudent(student);



}