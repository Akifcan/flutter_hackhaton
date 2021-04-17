import 'package:flutter/material.dart';
import 'package:help_together/views/detail-view/detail.dart';

class AppPostIcon extends StatelessWidget {
  final IconData icon;

  const AppPostIcon({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      iconSize: 35,
      icon: Icon(this.icon),
      onPressed: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => Detail())),
    );
  }
}
