import 'package:flutter/material.dart';
import 'package:help_together/views/detail-view/comments.dart';

class AppDetailButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const AppDetailButton(
      {Key key, this.icon, this.text, this.color = Colors.deepOrange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: this.color, padding: const EdgeInsets.all(15)),
          icon: Icon(this.icon),
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => Comments())),
          label: Text(this.text,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white))),
    );
  }
}
