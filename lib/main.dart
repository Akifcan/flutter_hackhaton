import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/theme/custom_theme.dart';
import 'package:help_together/views/home-view/home.dart';
import 'package:help_together/views/post-view/create_post.dart';
import 'package:help_together/views/sign-in-view/sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Storage.initialStorage();
  print(Storage.getString('location'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: SignIn(),
      routes: {'/home': (_) => Home(), '/create-post': (_) => CreatePost()},
    );
  }
}
