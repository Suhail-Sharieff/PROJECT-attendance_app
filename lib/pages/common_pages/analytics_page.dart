import 'package:attendance_app/constants/enums/sort_by.dart';
import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/data/models/schedule_model/schedule.dart';
import 'package:flutter/material.dart';

import '../../constants/Widgets/appBar.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/classes_model/classes_model.dart';
import '../../data/models/student_model/student_model.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key, required this.service});
  final StudentDBService service;

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {

  late final List<Student>list;
  late final StudentDBService service;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service=widget.service;
  }

  Future<void>fetchClasses()async{
    list=await service.getAllStudents(SortBy.nOfClassesAttended, Class(class_name: "CSE A"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Overall Analysis"),
        body: Column(
          children: [
            FutureBuilder(future: fetchClasses(), builder: (c,s){
              if(s.connectionState==ConnectionState.waiting){
                return Center(child:CircularProgressIndicator(),);
              }
              return Center(
                  child: Container(
                      height: 500,
                      child: SfCartesianChart(
                        legend: Legend(isVisible: true),
                        // Initialize category axis
                        title: ChartTitle(text: 'Half yearly sales analysis'),
                        primaryXAxis: CategoryAxis(),
                        series: [
                          // Initialize line series
                          FastLineSeries<Student, String>(
                            enableTooltip: true,gradient: LinearGradient(colors: [Colors.red,Colors.green,Colors.blue]),
                            dataSource: list,
                            xValueMapper: (Student e, _) => e.name,
                            yValueMapper: (Student e, _) => e.nOfClassesAttended,
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                            name: "Attendance",
                          )
                        ],

                      )
                  )
              );
            }),
          ],
        )
    );
  }
}
