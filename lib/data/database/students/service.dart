import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/abstract_provider.dart';
import 'package:attendance_app/data/database/students/provider.dart';
import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';

class StudentDBService implements StudentDBAbstractProvider{
  final instance=StudentDBProvider();
  @override
  Future<void> addStudent(Student newStudent) =>instance.addStudent(newStudent);
  @override
  Future<void> deleteStudent(Student student) =>instance.deleteStudent(student);
  @override
  Future<List<Student>> getAllStudents(SortBy how,Class whichClass) =>instance.getAllStudents(how,whichClass);
  @override
  Future<void> updateStudent(Student student) =>instance.updateStudent(student);
  @override
  Future<List<Map<String, dynamic>>> getStudentAttendanceMapList(Student student)=>instance.getStudentAttendanceMapList(student);
  @override
  Future<bool> isPresentToday(Student student)=>instance.isPresentToday(student);
  @override
  Future<void> markStudent(Student student) =>instance.markStudent(student);
  @override
  Future<void> refresh() =>instance.refresh();
  @override
  String getTodaysDate()=>instance.getTodaysDate();
  @override
  Future<void> addClass(Class newClass)=>instance.addClass(newClass);
  @override
  Future<void> deleteClass(Class c)=>instance.deleteClass(c);
  @override
  Future<List<Class>> getAllClasses() =>instance.getAllClasses();




}