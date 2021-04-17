import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage:
          NetworkImage('https://uifaces.co/our-content/donated/gPZwCbdS.jpg'),
    );
  }
}
