import 'dart:developer';

import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:attendance_app/data/state/attendance_state.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:attendance_app/data/state/student_state.dart';
import 'package:attendance_app/pages/student_pages/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

import '../../data/models/classes_model/classes_model.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key, required this.thisClass});
  final Class thisClass;
  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final TextEditingController nameContr = TextEditingController();
  late final Class myClass;
  SortBy sortBy = SortBy.name;

  @override
  void initState() {
    super.initState();
    myClass = widget.thisClass;
    log("Class being viewed: $myClass");
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<AttendanceState>(builder: (_,attendanceService,__){return Text(attendanceService.getTodaysDate());},),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<SortBy>(
            icon: const Icon(Icons.sort_sharp),
            tooltip: "Sort By ",
            itemBuilder: (context) {
              return [
                const PopupMenuItem<SortBy>(
                  value: SortBy.name,
                  child: Text('Name'),
                ),
                const PopupMenuItem<SortBy>(
                  value: SortBy.nOfClassesAttended,
                  child: Text('Attendance'),
                ),
                const PopupMenuItem<SortBy>(
                  value: SortBy.roll,
                  child: Text('Date added'),
                ),
              ];
            },
            onSelected: (val) async {
              setState(() {
                sortBy = val;
              });
            },
          )
        ],
      ),
      body: Consumer<StudentState>(builder: (_,studentService,__){

        final Map<Student,Map<String,int>>mp=studentService.student_date_isPresntMap;

        return FutureBuilder(
          future: studentService.loadAllStudents(sortBy, myClass), // Make sure this is triggering correctly
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Student>studentList=studentService.studentsList;

            if (studentList.isEmpty) {
              return Center(
                child: Text("No students added yet in ${myClass.class_name} !"),
              );
            }
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (_, idx) {

                Student st = studentList[idx];
                String today=studentService.getTodaysDate();
                bool isPresent=mp[st]![today]==1?true:false;

                
              },
            );
          },
        );
      }),
      floatingActionButton: Consumer<StudentState>(builder: (_,studentService,__){
        return FloatingActionButton(
          onPressed: () async {
            await showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text("Add new student"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Enter name of student")),
                          autofocus: true,
                          controller: nameContr,
                        ),
                        SizedBox.fromSize(
                          size: const Size(23, 23),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  if (nameContr.text.isNotEmpty) {
                                    await studentService.addStudent(Student(
                                        name: nameContr.text,
                                        className: myClass.class_name));
                                    await MyToast.showToast(
                                        "Added ${nameContr.text}", Colors.green);
                                    Navigator.of(context).pop();
                                    nameContr.clear();
                                    // await fetchData(); // Refresh data after adding
                                  } else {
                                    await MyToast.showErrorMsg(
                                        "Please provide name of student !",
                                        context);
                                  }
                                },
                                child: const Text("Add")),
                            SizedBox.fromSize(
                              size: const Size(23, 23),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                          ],
                        )
                      ],
                    ),
                  );
                });
            // setState(() {});
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
