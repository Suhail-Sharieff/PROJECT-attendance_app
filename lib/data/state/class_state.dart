import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:flutter/cupertino.dart';

import '../database/students/service.dart';

class ClassState with ChangeNotifier{
  final StudentDBService service;
  ClassState({required this.service});

  List<Class>classList=[];

  Future<List<Class>> getAllClasses() async{
    classList=await service.getAllClasses();
    return classList;
  }

  Future<void> addClass(Class newClass) async {
    await service.addClass(newClass);
    classList.add(newClass);
    notifyListeners();
  }

  Future<void>deleteClass(Class c)async{
    await service.deleteClass(c);
    classList.removeWhere((e)=>e.class_id==c.class_id);
    notifyListeners();
  }

  Future<int> nOfClassesTakenFor(Class c) async{
    int n=await service.nOfClassesTakenFor(c);
    return n;
  }


}
