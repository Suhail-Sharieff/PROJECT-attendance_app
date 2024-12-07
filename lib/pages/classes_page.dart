import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';


class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final service=StudentDBService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Classes "),
      body: Center(child: Text("No Classes Added Yet"),),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

        },
      ),
    );
  }
}
