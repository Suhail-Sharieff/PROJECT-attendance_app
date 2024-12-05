import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/student_model/student_model.dart';
import 'package:attendance_app/pages/student_profile.dart';
import 'package:flutter/material.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {

  // final List<Student>li=[
  //   Student(name: "Suhail",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 1),
  //   Student(name: "Sharieff",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 2),
  //   Student(name: "Sumera",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 3),
  //   Student(name: "Anjum",marksMap: {'IA1':23,'IA2':34},nOfClassesAttended: 0,roll: 4),
  // ];
  final service=StudentDBService();

  @override
  void initState() {
    super.initState();
  }
  List<Student>li=[];
  Future<void>fetchData()async{
    li=await service.getAllStudents();
    print(li);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Mark Attendance"),
      body: FutureBuilder(
        future: fetchData(),
        builder: (c,s){
          if(s.connectionState==ConnectionState.waiting) return const CircularProgressIndicator();
          if(li.isEmpty) return const Center(child: Text("No Items Yet"),);
          return  ListView.builder(
            itemCount: li.length,
            itemBuilder: (_,idx){
              Student st=li[idx];
              return ListTile(
                title: Text('ID : ${st.roll} : ${st.name}'),
                subtitle: Text('No of classes attended: ${st.nOfClassesAttended}'),
                onTap: ()async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>StudentProfilePage(student: st, instance: service,)));
                },
                onLongPress: ()async{
                  await service.deleteStudent(st);
                  setState(() {

                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
            await service.addStudent(Student(roll: 19,name: "Suhail"));
            setState(() {

            });

        },
        child:const  Icon(Icons.change_circle),
      ),
    );
  }
}
