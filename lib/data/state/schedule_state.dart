import 'package:attendance_app/data/models/schedule_model/schedule.dart';
import 'package:flutter/cupertino.dart';

import '../database/students/service.dart';

class ScheduleState with ChangeNotifier{
  final StudentDBService service;
  ScheduleState({required this.service});
}