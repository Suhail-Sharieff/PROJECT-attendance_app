import 'package:attendance_app/Utils/percent_indicator.dart';
import 'package:attendance_app/Utils/toast.dart';
import 'package:attendance_app/constants/routes/routes_names.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';

import '../data/models/student_model/student_model.dart';

class StudentProfilePage extends StatefulWidget {
  final Student student;
  final StudentDBService instance;
  const StudentProfilePage(
      {super.key, required this.student, required this.instance});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          // Ensures the screen resizes when the keyboard appears
          body: SingleChildScrollView(
            // Makes the whole page scrollable
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.pink.withOpacity(0.6),
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
                            Icons.animation,
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
                      const Text(
                        "Student Details :",
                        style: TextStyle(fontSize: 15, fontFamily: 'Inter'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(height: 10),
                      //circular progress bar
                      MyPercentIndicator.circular(
                          widget.student.nOfClassesAttended),

                      SizedBox.fromSize(
                        size: const Size.square(80),
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: Text(
                                      "Sure Delete ${widget.student.name} ?"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          ElevatedButton(
                                              onPressed: () async {
                                                await widget.instance
                                                    .deleteStudent(
                                                        widget.student);
                                                await MyToast.showToast(
                                                    "Delete Success",
                                                    Colors.green);
                                                Navigator.of(context).pop();
                                                await Navigator.of(context).pushReplacementNamed(attendanceRoute);
                                              },
                                              child: const Text("Yes")),
                                          SizedBox.fromSize(
                                            size: const Size(23, 23),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text("No")),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        icon: const Icon(Icons.login),
                        label: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 45,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(Radius.circular(23)),
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
                      // Space between buttons
                      // Sign Up link
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
