import 'package:attendance_app/pages/MorePage.dart';
import 'package:attendance_app/pages/analytics_page.dart';
import 'package:attendance_app/pages/attendance_page.dart';
import 'package:flutter/material.dart';




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

  void onChange(int idx){
    setState(() {
      currPageIdx=idx;
    });
  }

  final List<Widget> pages = const [
    AttendancePage(),
    AnalyticsPage(),
    MorePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currPageIdx],
      bottomNavigationBar: nb(currPageIdx, onChange),
    );
  }
}









