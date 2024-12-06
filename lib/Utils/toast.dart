
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyToast{
  static Future<void> showToast(String msg, Color backgroundColor) async{
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG
    );
  }
}