import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:flutter/material.dart';

import '../data/models/classes_model/classes_model.dart';


class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final service=StudentDBService();
  List<Class>classes=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchClasses();
  }
  
  Future<void>fetchClasses()async{
    classes=await service.getAllClasses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "My Classes "),
      body: FutureBuilder(future: fetchClasses(), builder: (c,s){
        if(s.connectionState==ConnectionState.waiting){
          return const CircularProgressIndicator();
        }
        if(classes.isEmpty) return const Center(child: Text("No class added yet !"),);
        return ListView.builder(
          itemCount: classes.length,
          itemBuilder: (_,idx){
            Class c=classes.elementAt(idx);
            return ListTile(
              title: Text(c.class_name),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add a new class",
        onPressed: ()async{
            await service.addClass(Class(class_name: "Sharieff"));
            setState(() {

            });
        },
      ),
    );
  }
}
