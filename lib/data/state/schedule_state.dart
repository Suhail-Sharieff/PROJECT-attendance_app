import 'package:attendance_app/data/models/schedule_model/schedule.dart';
import 'package:flutter/cupertino.dart';

import '../database/students/service.dart';

class ScheduleState with ChangeNotifier{
  final StudentDBService service;
  ScheduleState({required this.service});

  List<Schedule>scheduleList=[];

  Future<void>loadAllSchedules(String ddmmyy)async{
    scheduleList=await service.getAllSchedulesOn(ddmmyy);
  }

  Future<void> addSchedule(Schedule sh) async {
    await service.addSchedule(sh);
    scheduleList.add(sh);
    notifyListeners();
  }

  Future<void> deleteSchedule(Schedule sh) async {
    await service.deleteSchedule(sh);
    scheduleList.removeWhere((e)=>e.id==sh.id);
    notifyListeners();
  }

}