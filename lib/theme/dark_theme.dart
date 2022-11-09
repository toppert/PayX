import 'package:flutter/material.dart';
import 'package:payx/util/color_resources.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: Color(0xff032148),
  brightness: Brightness.dark,
  secondaryHeaderColor: Color(0xff1063d0),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: ColorResources.themeDarkBackgroundColor),
);
