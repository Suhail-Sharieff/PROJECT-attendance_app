import 'package:attendance_app/data/state/attendance_state.dart';
import 'package:attendance_app/data/state/class_state.dart';
import 'package:attendance_app/data/state/schedule_state.dart';
import 'package:attendance_app/pages/common_pages/home_page.dart';
import 'package:attendance_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/database/students/service.dart';
import 'data/state/student_state.dart';

void main() {
  final StudentDBService service=StudentDBService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>StudentState(service: service)),
        ChangeNotifierProvider(create: (_)=>ScheduleState(service: service)),
        ChangeNotifierProvider(create: (_)=>AttendanceState(service: service)),
        ChangeNotifierProvider(create: (_)=>ClassState(service: service)),
      ],
      child:  const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});



  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MySplashScreen(home: HomePage()),
      // home: const ClassesPage(),
    );
  }
}

