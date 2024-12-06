import 'package:attendance_app/Utils/percent_indicator.dart';
import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/routes/routes_names.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';

import '../data/models/student_model/student_model.dart';
import 'attendance_page.dart';

class StudentProfilePage extends StatefulWidget {
  final Student student;
  final StudentDBService service;
  const StudentProfilePage(
      {super.key, required this.student, required this.service});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    final instance = widget.service;
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
                              TextEditingController(text: widget.student.name);
                          TextEditingController attendContr =
                              TextEditingController(
                                  text: widget.student.nOfClassesAttended
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
                                          Student st = widget.student;
                                          await instance.updateStudent(
                                              st.copyWith(
                                                  roll: st.roll,
                                                  name: nameContr.text,
                                                  nOfClassesAttended: int.parse(
                                                      attendContr.text)));
                                          await MyToast.showToast(
                                              "Updated Successfully",
                                              Colors.green);
                                          Navigator.of(context)
                                              .pop(); // Close the bottom sheet or dialog
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const AttendancePage()),
                                                (Route<dynamic> route) =>
                                            false, // Remove all previous routes
                                          );
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
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.blue,
                          size: 44.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 12.0, 0.0, 0.0),
                      child: Text(
                        widget.student.name,
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
                      child: Text(
                        'Rg.No: ${widget.student.roll} ',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    //circular progress bar
                    MyPercentIndicator.circular(
                        widget.student.nOfClassesAttended),

                    SizedBox.fromSize(
                      size: const Size.square(80),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //delete
                        TextButton.icon(
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: Text(
                                      "Sure Delete ${widget.student.name} ?",
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            ElevatedButton(
                                                onPressed: () async {
                                                  await instance.deleteStudent(
                                                      widget.student);
                                                  await MyToast.showToast(
                                                      "Delete Success",
                                                      Colors.green);
                                                  Navigator.of(context)
                                                      .pop(); // Close the bottom sheet or dialog
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const AttendancePage()),
                                                    (Route<dynamic> route) =>
                                                        false, // Remove all previous routes
                                                  );
                                                },
                                                child: const Text("Yes")),
                                            SizedBox.fromSize(
                                              size: const Size(23, 23),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
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
  }
}
