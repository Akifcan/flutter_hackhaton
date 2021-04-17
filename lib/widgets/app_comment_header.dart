import 'package:flutter/material.dart';
import 'package:help_together/widgets/app_avatar.dart';

class AppCommentHeader extends StatelessWidget {
  const AppCommentHeader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: AppAvatar(),
          title: Text(
            'username',
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w300),
          ),
          subtitle: Text(
            'city',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Başlık Burada',
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
