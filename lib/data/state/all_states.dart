import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/cupertino.dart';

import '../models/classes_model/classes_model.dart';
import '../models/student_model/student_model.dart';

class MyAppState with ChangeNotifier {
  final StudentDBService service;
  final Class whichClass;

  MyAppState({required this.service, required this.whichClass});

  // Map<Student, Details>map = {};


}