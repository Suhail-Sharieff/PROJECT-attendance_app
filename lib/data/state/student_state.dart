import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';

import '../models/classes_model/classes_model.dart';
import '../models/student_model/student_model.dart';



class StudentState with ChangeNotifier {

  final StudentDBService service;
  StudentState({required this.service});

  //------------STUDENT LIST STATES

  List<Student>studentsList=[];
  
  Future<void>addStudent(Student newStudent)async{
    await service.addStudent(newStudent);
    studentsList.add(newStudent);
    notifyListeners();
  }
  Future<void>deleteStudent(Student student)async{
    await service.deleteStudent(student);
    studentsList.removeWhere((e)=>e.roll==student.roll);
    notifyListeners();
  }
  Future<void>updateStudent(Student student)async{
    await service.updateStudent(student);
    studentsList[studentsList.indexWhere((e)=>e.roll==student.roll)]=student;
    notifyListeners();
  }
  Future<void>getAllStudents(SortBy how,Class whichClass)async{
    studentsList=await service.getAllStudents(how, whichClass);
  }



}
