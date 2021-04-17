import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String avatarUrl;
  const AppAvatar({Key key, this.avatarUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundImage: NetworkImage(this.avatarUrl),
    );
  }
}
