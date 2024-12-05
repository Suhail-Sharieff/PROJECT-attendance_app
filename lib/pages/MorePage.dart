//page3
import 'package:attendance_app/constants/Widgets/appBar.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'More Options'),
      body: const Center(child: Text("This is third page"),),
    );
  }
}