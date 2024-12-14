import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/Widgets/appBar.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../data/models/classes_model/classes_model.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  static const headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 17, fontWeight: FontWeight.bold);
  static const contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  static const contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    return Consumer<ClassState>(builder:(_,classService,__){
      return Scaffold(
          appBar: MyAppBar(title: "Overall Analysis"),
          body: Accordion(
              headerBorderColor: Colors.blueGrey,
              headerBorderColorOpened: Colors.transparent,
              headerBorderWidth: 1,
              headerBackgroundColorOpened: Colors.green,
              contentBackgroundColor: Colors.white,
              contentBorderColor: Colors.green,
              contentBorderWidth: 3,
              contentHorizontalPadding: 12,
              scaleWhenAnimating: true,
              openAndCloseAnimation: true,
              headerPadding:
              const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
              sectionClosingHapticFeedback: SectionHapticFeedback.light,
              children: [
                AccordionSection(
                    isOpen: false,
                    contentVerticalPadding: 20,
                    leftIcon: const Icon(Icons.insert_chart, color: Colors.white),
                    header: const Text('No of classes per class',
                        style: headerStyle),
                    content: FutureBuilder(
                        future: classService.class_vs_nTaken(),
                        builder: (c, s) {
                          if (s.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          final class_vs_nTakenList=s.data!;
                          return Center(
                              child: Container(
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: SfCartesianChart(
                                      legend: const Legend(isVisible: true),
                                      // Initialize category axis
                                      title: const ChartTitle(
                                        // text: 'Class vs N.of class taken',
                                          textStyle: TextStyle(
                                              fontSize: 23, color: Colors.red)),
                                      primaryXAxis: const CategoryAxis(),
                                      series: [
                                        // Initialize line series
                                        ColumnSeries<C_n, String>(
                                          enableTooltip: true,
                                          dataSource: class_vs_nTakenList,
                                          xValueMapper: (C_n e, _) =>
                                          e.c.class_name,
                                          yValueMapper: (C_n e, _) => e.nTaken,
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true),
                                          name: "Chart",
                                        )
                                      ],
                                    ),
                                  )));
                        })),
                AccordionSection(
                    isOpen: false,
                    contentVerticalPadding: 20,
                    leftIcon: const Icon(Icons.insert_chart, color: Colors.white),
                    header: const Text('No of students per class',
                        style: headerStyle),
                    content: FutureBuilder<List<C_n>>(
                        future: classService.class_vs_nStudents(),
                        builder: (c, s) {
                          if (s.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Center(
                              child: Container(
                                  height: 400,
                                  child: SingleChildScrollView(
                                    child: SfCartesianChart(
                                      legend: const Legend(isVisible: true),
                                      // Initialize category axis
                                      title: const ChartTitle(
                                          textStyle: TextStyle(
                                              fontSize: 23, color: Colors.red)),
                                      primaryXAxis: const CategoryAxis(),
                                      series: [
                                        // Initialize line series
                                        ColumnSeries<C_n, String>(
                                          enableTooltip: true,
                                          dataSource: s.data!,
                                          xValueMapper: (C_n e, _) =>
                                          e.c.class_name,
                                          yValueMapper: (C_n e, _) => e.nTaken,
                                          dataLabelSettings:
                                          const DataLabelSettings(
                                              isVisible: true),
                                          name: "Chart",
                                        )
                                      ],
                                    ),
                                  )));
                        })),
              ]));
    });
  }
}

class C_n {
  final Class c;
  final int nTaken;
  const C_n(this.c, this.nTaken);
}
