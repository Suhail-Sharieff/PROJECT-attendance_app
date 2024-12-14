import 'package:attendance_app/data/database/students/constants.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/enums/sort_by.dart';
import '../models/classes_model/classes_model.dart';
import '../models/details_model/details_model.dart';
import '../models/student_model/student_model.dart';

class AttendancePageState with ChangeNotifier {
  final StudentDBService service;

  AttendancePageState({required this.service});

  Map<Student, Details> map = {};

  Future<void> load(SortBy how, Class whichClass) async {
    map.clear();
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
      bool isPresentToday = await service.isPresentToday(student);
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
        isPresentToday: isPresentToday,
      );
      // notifyListeners();
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
    print("ADDING");
    notifyListeners();
  }

  Future<void> markStudent(Student student) async {
    Details currDetails = map[student]!;
    await service.markStudent(student);
    if (currDetails.isPresentToday) {
      //he is present today but we are calling mark, means mark absent and decrese nOfClassesAttened
      map[student] = currDetails.copyWith(isPresentToday: false,nOfClassesAttended: student.nOfClassesAttended + 1);
    } else {
      map[student] = currDetails.copyWith(
          isPresentToday: true,
          nOfClassesAttended: student.nOfClassesAttended + 1);
    }
    notifyListeners();
  }


  List<Student>getStudentList(){
    // print("list---->${map.keys.toList()}");
    return map.keys.toList();
  }
  String getTodaysDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(now);
  }
}
