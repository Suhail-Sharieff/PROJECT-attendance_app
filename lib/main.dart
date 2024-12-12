import 'package:attendance_app/data/database/students/provider.dart';
import 'package:attendance_app/pages/common_pages/calendar_page.dart';
import 'package:attendance_app/pages/common_pages/home_page.dart';
import 'package:attendance_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/routes/routes_names.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>StudentDBProvider())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      routes: {
        homeRoute:(context)=>const HomePage(),
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
