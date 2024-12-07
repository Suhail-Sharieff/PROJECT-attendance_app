import 'dart:developer';

import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:attendance_app/pages/student_profile.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final service = StudentDBService();
  final TextEditingController nameContr = TextEditingController();
  SortBy sortBy = SortBy.name;

  List<Student> li = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch initial data
  }

  Future<void> fetchData() async {
    li = await service.getAllStudents(sortBy);
  }

  Future<bool> isStudentPresentTody(Student student) async {
    bool res = await service.isPresentToday(student);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mark Attendance"),
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
              await fetchData(); // Re-fetch data based on the new sort option
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchData(), // Make sure this is triggering correctly
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (li.isEmpty) {
            return const Center(
              child: Text("No Items Yet"),
            );
          }
          return ListView.builder(
            itemCount: li.length,
            itemBuilder: (_, idx) {
              Student st = li[idx];
              return FutureBuilder(
                future: isStudentPresentTody(st),
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  bool isPresent = snap.data!;
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical:
                                8), // Padding to make the list tile feel more spacious
                        leading: CircleAvatar(child: Text('${idx+1}'),backgroundColor: Colors.yellow,),
                        trailing: IconButton(
                            onPressed: () async {
                              await service.markStudent(st);
                              setState(() {});
                            },
                            icon: (isPresent)
                                ? (const Icon(Icons.back_hand,color: Colors.green,applyTextScaling: true,))
                                : const Icon(Icons
                                    .remove)), // Leading icon to represent the student
                        title: Text(
                          'ID : ${idx+1}: ${st.name}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          'Attended: ${st.nOfClassesAttended}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        onLongPress: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => StudentProfilePage(
                              student: st,
                              service: service,
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
        },
      ),
      floatingActionButton: FloatingActionButton(
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
                                  await service.addStudent(
                                      Student(name: nameContr.text));
                                  await MyToast.showToast(
                                      "Added ${nameContr.text}", Colors.green);
                                  Navigator.of(context).pop();
                                  nameContr.clear();
                                  await fetchData(); // Refresh data after adding
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
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
