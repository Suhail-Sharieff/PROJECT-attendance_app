import 'package:flutter/material.dart';

import '../../constants/Widgets/appBar.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: MyAppBar(title: "Analytics"),
      body:  const Center(child: Text("This is second page"),),
    );
  }
}
