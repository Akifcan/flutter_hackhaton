import 'package:flutter/material.dart';

class AppDetailButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final IconData icon;
  final String text;
  final Color color;

  const AppDetailButton(
      {Key key,
      this.icon,
      this.text,
      this.voidCallback,
      this.color = Colors.deepOrange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: this.color, padding: const EdgeInsets.all(15)),
          icon: Icon(this.icon),
          onPressed: this.voidCallback,
          label: Text(this.text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white))),
    );
  }
}
