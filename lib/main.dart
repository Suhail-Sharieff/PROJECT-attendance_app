import 'package:attendance_app/pages/teacher_pages/classes_page.dart';
import 'package:attendance_app/pages/common_pages/MorePage.dart';
import 'package:attendance_app/pages/common_pages/analytics_page.dart';
import 'package:attendance_app/pages/teacher_pages/attendance_page.dart';
import 'package:attendance_app/pages/common_pages/home_page.dart';
import 'package:attendance_app/splash_screen.dart';
import 'package:flutter/material.dart';

import 'constants/routes/routes_names.dart';
import 'data/models/classes_model/classes_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        homeRoute:(context)=>const HomePage(),
        analyticsRoute:(context)=>const AnalyticsPage(),
        moreRoute:(context)=>const MorePage(),
      },
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MySplashScreen(home: HomePage()),
      // home: const ClassesPage(),
    );
  }
}
