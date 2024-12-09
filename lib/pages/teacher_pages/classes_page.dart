import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/pages/teacher_pages/attendance_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/classes_model/classes_model.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key, required this.service});
  final StudentDBService service;

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  late final service;
  final classNameController = TextEditingController();
  List<Class> classes = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service=widget.service;
    fetchClasses();
  }

  Future<void> fetchClasses() async {
    classes = await service.getAllClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Classes "),
      body: FutureBuilder(
          future: fetchClasses(),
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (classes.isEmpty) {
              return const Center(
                child: Text("No class added yet !"),
              );
            }
            return GridView.builder(
                itemCount: classes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, idx) {
                  Class curr = classes[idx];
                  return GestureDetector(
                    child: Container(
                      height: 23,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: Colors.blueAccent.withOpacity(0.3),
                          border: Border.all(
                              width: 2,
                              color: Colors.blueGrey,
                              style: BorderStyle.solid)),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      child: Center(child: Text(curr.class_name,style: const TextStyle(fontSize: 15,wordSpacing: 2,color: Colors.red,fontWeight: FontWeight.bold),)),
                    ),
                    onLongPress: () async {
                      await service.deleteClass(curr);
                      setState(() {});
                    },
                    onTap: ()async{
                      await Navigator.push(context, MaterialPageRoute(builder: (_)=>AttendancePage(thisClass: curr, service: service,)));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new class",
        onPressed: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(
                      child: Text(
                    "Add a new Class !",
                    style: TextStyle(fontSize: 15),
                  )),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: classNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Enter Class Name ")),
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () async {
                              if (classNameController.text.isNotEmpty) {
                                await service.addClass(Class(
                                    class_name: classNameController.text
                                        .toUpperCase()));
                                await MyToast.showToast(
                                    "Created successfully", Colors.green);
                                classNameController.clear();
                                Navigator.of(context).pop();
                              } else {
                                await MyToast.showErrorMsg(
                                    "Class name cannot be empty !", context);
                              }
                              setState(() {});
                            },
                            child: const Text("Add")),
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add_box_outlined),
      ),
    );
  }
}
