import 'dart:developer';
import 'dart:math';

import 'package:attendance_app/Utils/percent_indicator.dart';
import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/constants.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/details_model/details_model.dart';
import 'package:attendance_app/data/state/attendance_page_state.dart';
import 'package:attendance_app/data/state/attendance_state.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:attendance_app/data/state/student_state.dart';
import 'package:attendance_app/pages/common_pages/home_page.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/classes_model/classes_model.dart';
import '../../data/models/student_model/student_model.dart';

class StudentProfilePage extends StatefulWidget {
  final Student student;
  final Class hisClass;
  const StudentProfilePage(
      {super.key, required this.student, required this.hisClass});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  // Define headers for your columns


  late final Student student;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    student = widget.student;
    // log("Student being viewed: $student");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ClassState>(builder: (_, classService, __) {
      return Consumer<AttendanceState>(builder: (_, attendanceService, __) {
        return Consumer<StudentState>(builder: (_, studentService, __) {
          return Material(
            color: Colors.white,
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  "Student Details",
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                backgroundColor: Colors.blue.withOpacity(0.6),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                TextEditingController nameContr =
                                    TextEditingController(text: student.name);
                                TextEditingController attendContr =
                                    TextEditingController(
                                        text: student.nOfClassesAttended
                                            .toString());
                                return AlertDialog(
                                  title: const Text(
                                    "Edit Student Data",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Update name")),
                                        controller: nameContr,
                                      ),
                                      SizedBox.fromSize(
                                        size: const Size(30, 30),
                                      ),
                                      TextField(
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            label: Text("Update attendance %")),
                                        controller: attendContr,
                                      ),
                                      SizedBox.fromSize(
                                        size: const Size(30, 30),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                if (nameContr.text.isNotEmpty) {
                                                  Student st = student;
                                                  await studentService
                                                      .updateStudent(st.copyWith(
                                                          className:
                                                              st.className,
                                                          roll: st.roll,
                                                          name: nameContr.text,
                                                          nOfClassesAttended:
                                                              int.parse(
                                                                  attendContr
                                                                      .text)));
                                                  await MyToast.showToast(
                                                      "Updated Successfully",
                                                      Colors.green);
                                                  Navigator.of(context)
                                                      .pop(); // Close the bottom sheet or dialog
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomePage()),
                                                    (Route<dynamic> route) =>
                                                        false, // Remove all previous routes
                                                  );

                                                } else {
                                                  await MyToast.showErrorMsg(
                                                      "Name cannot be empty !",
                                                      context);
                                                }
                                              },
                                              child: const Text("Update")),
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
                        },
                        icon: const Icon(Icons.edit)),
                  )
                ],
              ),
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.6),
                            // Cyan/Turquoise
                            const Color(0x00FFFFFF),
                            // Transparent (adjust if needed)
                          ],
                          begin: const AlignmentDirectional(0.0, -1.0),
                          end: const AlignmentDirectional(0, 1.3),
                          stops: const [0.0, 1.0],
                        ),
                      ),
                      width: double.infinity,
                      height: 300,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                foregroundColor: Colors.blueAccent,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '${widget.student.roll}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 12.0, 0.0, 0.0),
                            child: Text(
                              student.name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter Tight',
                                letterSpacing: 0.0,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: Column(
                              children: [
                                Text(
                                  '${student.className} ',
                                  style: const TextStyle(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Consumer<AttendancePageState>(builder: (_,ser,__){
                          //   Details? d=ser.map[student];
                          //   return Padding(
                          //     padding: const EdgeInsetsDirectional.fromSTEB(
                          //         0.0, 4.0, 0.0, 0.0),
                          //     child: Column(
                          //       children: [
                          //         Text(
                          //           'Attended ${min(d!.nOfClassesAttended,d.nOfClassesTakenForHisClass)}/${d.nOfClassesTakenForHisClass} ',
                          //           style: const TextStyle(
                          //             fontFamily: 'Inter',
                          //             letterSpacing: 0.0,
                          //             fontWeight: FontWeight.bold
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   );
                          // }),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 0.0),
                            child: Column(
                              children: [
                                FutureBuilder(future: classService.nOfClassesTakenFor(widget.hisClass), builder: (c,s){
                                  if(s.connectionState==ConnectionState.waiting){
                                    return const CircularProgressIndicator();
                                  }
                                  return Text(
                                    'Attended ${min(student.nOfClassesAttended, s.data!)}/${s.data!} ',
                                    style: const TextStyle(
                                        fontFamily: 'Inter',
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  );
                                }),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 32),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          //circular progress bar
                          Consumer<ClassState>(builder: (_, classService, __) {
                            return FutureBuilder(
                                future: classService
                                    .nOfClassesTakenFor(widget.hisClass),
                                builder: (s, c) {
                                  if (c.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return MyPercentIndicator.circular(
                                      student.nOfClassesAttended / c.data!);
                                });
                          }),

                          SizedBox.fromSize(
                            size: const Size(30, 30),
                          ),

                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TextButton.icon(
                                onPressed: () async {
                                  setState(() {

                                  });
                                },
                                icon: const Icon(Icons.refresh),
                                label: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(23)),
                                  ),
                                  child: const Text(
                                    'Refresh',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              //delete
                              TextButton.icon(
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: Text(
                                            "Sure Delete ${student.name} ?",
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        await studentService
                                                            .deleteStudent(
                                                                student);
                                                        await MyToast.showToast(
                                                            "Delete Success",
                                                            Colors.green);
                                                        Navigator.of(context)
                                                            .pop(); // Close the bottom sheet or dialog
                                                        Navigator.of(context)
                                                            .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const HomePage()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false, // Remove all previous routes
                                                        );
                                                      },
                                                      child: const Text("Yes")),
                                                  SizedBox.fromSize(
                                                    size: const Size(23, 23),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child:
                                                          const Text("Cancel")),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.delete),
                                label: Container(
                                  alignment: Alignment.center,
                                  width: 150,
                                  height: 45,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(23)),
                                  ),
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Space between buttons
                          // Sign Up link
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      });
    });
  }
}
