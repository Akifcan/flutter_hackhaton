import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppPostIcon extends StatelessWidget {
  final IconData icon;
  final DocumentSnapshot detail;
  final VoidCallback voidCallback;

  const AppPostIcon({Key key, this.icon, this.detail, this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.white,
        iconSize: 35,
        icon: Icon(this.icon),
        onPressed: this.voidCallback);
  }
}
