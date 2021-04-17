import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
    iconTheme: IconThemeData(color: Colors.deepOrange),
    inputDecorationTheme: InputDecorationTheme(filled: true),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange),
    textTheme: TextTheme(subtitle1: TextStyle(fontSize: 22)),
    primaryColor: Color(0xffdedede),
    scaffoldBackgroundColor: Colors.deepOrange);

List<LinearGradient> gradients = [
  LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffcb2d3e),
        Color(0xffef473a),
      ]),
  LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffef473a),
        Color(0xffcb2d3e),
      ]),
  LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xffff6a00),
        Color(0xffef473a),
      ]),
];
