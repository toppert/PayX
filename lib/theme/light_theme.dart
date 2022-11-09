import 'package:flutter/material.dart';
import 'package:payx/util/color_resources.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Rubik',
  primaryColor: Color(0xFF032148),
  secondaryHeaderColor: Color(0xFF1063D0),
  highlightColor: Color(0xFF003089),
  backgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: ColorResources.themeLightBackgroundColor),
);
