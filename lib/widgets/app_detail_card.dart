import 'package:flutter/material.dart';

class AppDetailCard extends StatelessWidget {
  final Widget text;
  const AppDetailCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[900], borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(6),
        child: Center(
          child: this.text,
        ),
      ),
    );
  }
}
