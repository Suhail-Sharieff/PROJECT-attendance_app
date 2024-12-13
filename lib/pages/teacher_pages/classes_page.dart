import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:attendance_app/pages/teacher_pages/attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/classes_model/classes_model.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final classNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Classes "),

      body: Consumer<ClassState>(builder: (_,classService,__){
        return FutureBuilder(future: classService.loadAllClasses(), builder: (c,s){
          List<Class>classList=classService.classList;
          return GridView.builder(
              itemCount: classList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (_, idx) {
                Class curr = classList[idx];
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
                    child: Center(
                        child: Text(
                          curr.class_name,
                          style: const TextStyle(
                              fontSize: 15,
                              wordSpacing: 2,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  onLongPress: () async {
                    await classService.deleteClass(curr);
                  },
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AttendancePage(
                              thisClass: curr,
                            )));
                  },
                );
              });
        });
      }),
      floatingActionButton: Consumer<ClassState>(builder: (_,classService,__){
        return FloatingActionButton(
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
                                  await classService.addClass(Class(
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
                              },
                              child: const Text("Add")),
                        )
                      ],
                    ),
                  );
                });
          },
          child: const Icon(Icons.add_box_outlined),
        );
      }),
    );
  }
}
