import 'package:flutter/material.dart';

class AppDetailCard extends StatelessWidget {
  final String text;
  const AppDetailCard({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[900], borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(12),
        child: Center(
            child: Text(this.text,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white))),
      ),
    );
  }
}
