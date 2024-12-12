import 'package:flutter/cupertino.dart';

import '../database/students/service.dart';
import '../models/classes_model/classes_model.dart';
import '../models/student_model/student_model.dart';

class AttendanceState with ChangeNotifier{
  final StudentDBService service;
  AttendanceState({required this.service});

  List<Map<String, dynamic>>studentAttendanceMapList=[];

  Future<List<Map<String, dynamic>>> getStudentAttendanceMapList(
      Student student) async {
    studentAttendanceMapList=await getStudentAttendanceMapList(student);
      return studentAttendanceMapList;
  }

  String getTodaysDate(){
    String s=service.getTodaysDate();
    return s;
  }

  Future<void> markStudent(Student student) async {
    await service.markStudent(student);
    studentAttendanceMapList=await service.getStudentAttendanceMapList(student);
    notifyListeners();
  }

  Future<bool> isPresentToday(Student student) async {
    bool b=await service.isPresentToday(student);
    return b;
  }

  Future<void> refresh(Class forWhichClass) async{
    await service.refresh(forWhichClass);
    notifyListeners();
  }



}