import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  final List<Student>li=[
    Student(name: "Suhail",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 1),
    Student(name: "Sharieff",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 2),
    Student(name: "Sumera",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 3),
    Student(name: "Anjum",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Mark Attendance"),
      body: ListView.builder(
        itemCount: li.length,
        itemBuilder: (_,idx){
          Student st=li[idx];
          return ListTile(
            title: Text('ID : ${st.roll} : ${st.name}'),
            subtitle: Text('No of classes attended: ${st.nOfClassesAttended}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          li[0]=li[0].copyWith(nOfClassesAttended: li[0].nOfClassesAttended+1);
          setState(() {

          });
        },
        child:const  Icon(Icons.change_circle),
      ),
    );
  }
}
