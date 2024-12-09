import 'package:attendance_app/data/database/students/service.dart';
import 'package:attendance_app/pages/common_pages/MorePage.dart';
import 'package:attendance_app/pages/common_pages/analytics_page.dart';
import 'package:attendance_app/pages/teacher_pages/attendance_page.dart';
import 'package:attendance_app/pages/teacher_pages/classes_page.dart';
import 'package:flutter/material.dart';

import '../../data/models/classes_model/classes_model.dart';




NavigationBar nb(int currentPageIndex,Function(int) onChange) {
  return NavigationBar(
    labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    selectedIndex: currentPageIndex,
    onDestinationSelected: onChange,
    destinations: const <Widget>[
      NavigationDestination(
        icon: Icon(Icons.front_hand),
        label: 'Attendance',
      ),
      NavigationDestination(
        icon: Icon(Icons.analytics),
        label: 'Analytics',
      ),

      NavigationDestination(
        icon: Icon(Icons.more_horiz),
        label: 'More',
      ),
    ],
  );
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currPageIdx=0;
  late final StudentDBService service;

  void onChange(int idx){
    setState(() {
      currPageIdx=idx;
    });
  }
  late final List<Widget>pages;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service=StudentDBService();
    pages = [
      ClassesPage(service: service),
      const AnalyticsPage(),
      const MorePage(),
    ];
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currPageIdx],
      bottomNavigationBar: nb(currPageIdx, onChange),
    );
  }
}









