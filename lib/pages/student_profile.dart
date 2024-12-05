import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';

import '../data/models/student_model/student_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:fluttertoast/fluttertoast.dart';
class StudentProfilePage extends StatefulWidget {
  final Student student;
  final StudentDBService instance;
  const StudentProfilePage({super.key,required this.student,required this.instance});

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
          body: SingleChildScrollView( // Makes the whole page scrollable
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
                          'Rg.No: ${widget.student
                              .roll} ',
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32),
                  child: Column(
                    children: [
                      const Text("Student Details :",
                        style: TextStyle(fontSize: 15, fontFamily: 'Inter'),),
                      const SizedBox(height: 10,),
                      const SizedBox(height: 10),
                      //circular progress bar
                      circular(widget.student.nOfClassesAttended),

                      SizedBox.fromSize(size: const Size.square(80),),
                      TextButton.icon(
                        onPressed: () async {
                          await showDialog(context: context, builder: (_) {
                            return AlertDialog(
                              title: Text(
                                  "Sure Delete ${widget.student.name} ?"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      ElevatedButton(onPressed: () async {
                                        await widget.instance.deleteStudent(
                                            widget.student);
                                        showToast(
                                            "Delete Success", Colors.green);
                                      }, child: const Text("Yes")),
                                      ElevatedButton(onPressed: () {
                                        Navigator.of(context).pop();
                                      }, child: const Text("Yes")),
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


  static Center circular(int value) {
    String st = "${double.tryParse(value.toString())} %";
    return Center(
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 13.0,
        animation: true,
        percent: value / 100,
        center: Text(
          st,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        footer: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "Attendance %",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        linearGradient:
        const LinearGradient(colors: [Colors.red, Colors.green, Colors.blue]),
      ),
    );
  }

  static void showToast(String msg, Color backgroundColor) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG
    );
  }
}