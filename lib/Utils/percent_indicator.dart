import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyPercentIndicator{
  static  Center circular(int value) {
    String st = "${double.tryParse(value.toString())} %";
    return Center(
      child: CircularPercentIndicator(
        radius: 80.0,
        lineWidth: 13.0,
        animation: true,
        percent: value %2,
        center: Text(
          st,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
        ),
        footer: const Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text(
            "Attendance %",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        linearGradient:
        const LinearGradient(colors: [Colors.red, Colors.green, Colors.blue]),
      ),
    );
  }

}