import 'package:flutter/cupertino.dart';

import '../database/students/service.dart';

class AttendanceState with ChangeNotifier{
  final StudentDBService service;
  AttendanceState({required this.service});
}