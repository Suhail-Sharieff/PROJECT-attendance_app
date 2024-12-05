 import 'package:attendance_app/constants/text/texts.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

AppBar MyAppBar({required String title}){
  return AppBar(
    title: Text(title),
    centerTitle: true,
    clipBehavior: Clip.hardEdge,
    backgroundColor: NavBarColor,
    foregroundColor: NavBarTextColor,
    toolbarOpacity: 1,
  );
}