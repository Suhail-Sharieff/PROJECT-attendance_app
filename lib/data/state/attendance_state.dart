import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../database/students/constants.dart';
import '../database/students/service.dart';
import '../models/student_model/student_model.dart';

class AttendanceState with ChangeNotifier {
  final StudentDBService service;
  AttendanceState({required this.service});

  List<Map<String, dynamic>> studentAttendanceMapList = [];
  //this maplist contains data as {attendanceID: 44, roll: 16, isPresentThatDay: 1, date: 13/12/2024, class_name: CSE A}]
  Map<int,Map<String,int>>roll_date_isPresntMap={};//----we use

  Future<void> loadMapList(Student student) async {
    studentAttendanceMapList =
        await service.getStudentAttendanceMapList(student);
  }



  Future<void> loadMap()async{
    for(var e in studentAttendanceMapList){
      int roll=e[rollCol];
      String date=e[dateCol];
      int isPresent=e[isPresentCol];
      roll_date_isPresntMap[roll]={date:isPresent};
    }
  }
  String getTodaysDate() {
    //using intl package
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }


  Future<void>markStudent(Student student)async{
    await service.markStudent(student);
    String today=getTodaysDate();
    int? p=roll_date_isPresntMap[student.roll]?[today];
    if(p==0){
      roll_date_isPresntMap[student.roll]?[today]=1;
    }else{
      roll_date_isPresntMap[student.roll]?[today]=10;
    }
    notifyListeners();
  }


}
