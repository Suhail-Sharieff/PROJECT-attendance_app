import 'package:attendance_app/data/database/students/constants.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enums/sort_by.dart';
import '../models/classes_model/classes_model.dart';
import '../models/details_model/details_model.dart';
import '../models/student_model/student_model.dart';

class MyAppState with ChangeNotifier {
  final StudentDBService service;

  MyAppState({required this.service});

  Map<Student, Details> map = {};

  Future<void> load(SortBy how, Class whichClass) async {
    final List<Student> students =
        await service.getAllStudents(how, whichClass);

    int nOFClassesTakenForHisClass =
        await service.nOfClassesTakenFor(whichClass);
    //this attendance history looks like this
    //this[{ attendanceID: 44, roll: 16, isPresentThatDay: 1, date: 13/12/2024, class_name: CSE A}]

    for (Student student in students) {
      final List<Map<String, dynamic>> attendanceHistory =
          await service.getStudentAttendanceMapList(student);
      List<String> dates = [];
      for (Map<String, dynamic> eachMap in attendanceHistory) {
        dates.add(eachMap[dateCol]);
      }

      map[student] = Details(
        name: student.name,
        className: student.className,
        nOfClassesAttended: student.nOfClassesAttended,
        roll: student.roll,
        nOfClassesTakenForHisClass: nOFClassesTakenForHisClass,
        attendanceDatesList: dates,
      );
    }
  }

  Future<void> addStudent(Student student) async {
    await service.addStudent(student);
    int nOFClassesTakenForHisClass =
        await service.nOfClassesTakenFor(Class(class_name: student.className));
    map[student] = Details(
        roll: student.roll,
        name: student.name,
        className: student.className,
        nOfClassesTakenForHisClass: nOFClassesTakenForHisClass);
  }
}
