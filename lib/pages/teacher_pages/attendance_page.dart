import 'dart:developer';

import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/models/details_model/details_model.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:attendance_app/data/state/attendance_page_state.dart';
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
        title: Consumer<AttendanceState>(
          builder: (_, attendanceService, __) {
            return Text(attendanceService.getTodaysDate());
          },
        ),
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
      body: Consumer<AttendancePageState>(builder: (_, service, __) {
        // final Map<Student,Map<String,int>>mp=service.student_date_isPresntMap;
        final Map<Student, Details> mp = service.map;

        return FutureBuilder(
          future: service.load(
              sortBy, myClass), // Make sure this is triggering correctly
          builder: (c, s) {
            if (s.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            List<Student> studentList = service.getStudentList();

            if (studentList.isEmpty) {
              return Center(
                child: Text("No students added yet in ${myClass.class_name} !"),
              );
            }
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (_, idx) {
                Student st = studentList[idx];
                Details details = mp[st]!;
                String today = service.getTodaysDate();
                bool isPresent = details.isPresentToday;
                int nAttended = details.nOfClassesAttended;
                int nTotal = details.nOfClassesTakenForHisClass;

                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical:
                              8), // Padding to make the list tile feel more spacious
                      leading: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        child: Text('${idx + 1}'),
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            await service.markStudent(st);
                          },
                          icon: (isPresent)
                              ? (const Icon(
                                  Icons.back_hand,
                                  color: Colors.green,
                                  applyTextScaling: true,
                                ))
                              : const Icon(Icons
                                  .remove)), // Leading icon to represent the student
                      title: Text(
                        'ID : ${idx + 1}: ${st.name}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        'Attended: $nAttended/$nTotal',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      onLongPress: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => StudentProfilePage(
                            student: st,
                            hisClass: myClass,
                          ),
                        ));
                      },

                      tileColor:
                          Colors.grey[50], // Add a background color to the tile
                      shape: RoundedRectangleBorder(
                        // Round the corners of the tile for a more modern look
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // elevation: 2,  // Adding a subtle shadow to lift the tile visually
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          },
        );
      }),
      floatingActionButton:
          Consumer<StudentState>(builder: (_, studentService, __) {
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
                                        "Added ${nameContr.text}",
                                        Colors.green);
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
