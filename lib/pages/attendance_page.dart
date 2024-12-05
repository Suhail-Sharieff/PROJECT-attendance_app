import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Mark Attendance"),
      body: const Center(
        child: Text("This is first page"),
      ),
    );
  }
}
