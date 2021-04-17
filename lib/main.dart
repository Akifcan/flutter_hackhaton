import 'package:flutter/material.dart';
import 'package:help_together/theme/custom_theme.dart';
import 'package:help_together/views/home-view/home.dart';
import 'package:help_together/views/sign-in-view/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: SignIn(),
    );
  }
}
