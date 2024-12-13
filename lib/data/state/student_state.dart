import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/classes_model/classes_model.dart';
import '../models/student_model/student_model.dart';



class StudentState with ChangeNotifier {

  final StudentDBService service;
  StudentState({required this.service});


  List<Student>studentsList=[];
  Map<Student,Map<String,int>>student_date_isPresntMap={};

  Future<void>loadAllStudents(SortBy how,Class whichClass)async{
    studentsList=await service.getAllStudents(how, whichClass);
    for(Student each in studentsList){
      String date=service.getTodaysDate();
      int isPresent=0;
      student_date_isPresntMap[each]={date:isPresent};
    }
  }
  
  Future<void>addStudent(Student newStudent)async{
    await service.addStudent(newStudent);
    studentsList.add(newStudent);
    String date=service.getTodaysDate();
    int isPresent=0;
    student_date_isPresntMap[newStudent]={date:isPresent};
    notifyListeners();
  }
  Future<void>deleteStudent(Student student)async{
    await service.deleteStudent(student);
    studentsList.removeWhere((e)=>e.roll==student.roll);
    student_date_isPresntMap.remove(student);
    notifyListeners();
  }
  Future<void>updateStudent(Student student)async{
    await service.updateStudent(student);
    studentsList[studentsList.indexWhere((e)=>e.roll==student.roll)]=student;
    final k=student_date_isPresntMap.keys.where((e)=>e.roll==student.roll).first;
    notifyListeners();
  }

  Future<bool> isStudentPresentToday(Student st) async {
    return student_date_isPresntMap[st]![service.getTodaysDate()]==1;
  }

  // Future<List<Map<String,dynamic>>>fetchStudentAttendance(Student st)async{
  //   final List<Map<String,dynamic>> data=await service.getStudentAttendanceMapList(st);//List<Map<String,dynamic>>
  //   return data;
  // }
  String getTodaysDate() {
    //using intl package
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }
}
