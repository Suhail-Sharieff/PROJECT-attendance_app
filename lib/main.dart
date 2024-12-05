import 'package:attendance_app/pages/home_page.dart';
import 'package:attendance_app/splash_screen.dart';
import 'package:flutter/material.dart';

import 'constants/routes/routes_names.dart';

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
        homeRoute:(context)=>const HomePage()
      },
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MySplashScreen(home: HomePage()),
    );
  }
}
