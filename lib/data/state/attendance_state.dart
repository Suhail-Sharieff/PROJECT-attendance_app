import 'package:attendance_app/constants/routes/routes_names.dart';
import 'package:flutter/cupertino.dart';

import '../database/students/constants.dart';
import '../database/students/service.dart';
import '../models/classes_model/classes_model.dart';
import '../models/student_model/student_model.dart';

class AttendanceState with ChangeNotifier {
  final StudentDBService service;
  AttendanceState({required this.service});

  List<Map<String, dynamic>> studentAttendanceMapList = [];

  Future<void> loadStudentAttendanceMapList(Student student) async {
    studentAttendanceMapList =
        await service.getStudentAttendanceMapList(student);
  }

  //this maplist contains data as {attendanceID: 44, roll: 16, isPresentThatDay: 1, date: 13/12/2024, class_name: CSE A}]
  Map<int,Map<String,int>>roll_date_isPresntMap={};

  //initialize roll_date_isPresent map
  Future<void> initializeMap()async{
    //assume that u have loaded first
    for(var e in studentAttendanceMapList){
      int roll=e[rollCol];
      String date=e[dateCol];
      int isPresent=e[isPresentCol];
      roll_date_isPresntMap[roll]={date:isPresent};
    }
  }




}
