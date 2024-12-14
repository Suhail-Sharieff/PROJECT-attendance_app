import 'package:attendance_app/data/models/classes_model/classes_model.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/enums/sort_by.dart';
import '../../pages/common_pages/analytics_page.dart';
import '../database/students/service.dart';

class ClassState with ChangeNotifier{
  final StudentDBService service;
  ClassState({required this.service});

  List<Class>classList=[];

  Future<void>loadAllClasses()async{
    classList=await service.getAllClasses();
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


  Future<List<C_n>> class_vs_nTaken() async {
    List<C_n> class_vs_nTakenList = [];
    for (Class each in classList) {
      int n = await service.nOfClassesTakenFor(each);
      class_vs_nTakenList.add(C_n(each, n));
    }
    return class_vs_nTakenList;
  }


  Future<List<C_n>>class_vs_nStudents()async{
    List<C_n>class_vs_nOfStudents=[];
    for(Class each in classList){
      int n=await service.getAllStudents(SortBy.name, each).then((val)=>val.length);
      class_vs_nOfStudents.add(C_n(each, n));
    }
    return class_vs_nOfStudents;
  }
}
