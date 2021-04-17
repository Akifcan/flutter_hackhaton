import 'package:flutter/material.dart';

import 'app_avatar.dart';

class AppCommentCard extends StatelessWidget {
  const AppCommentCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).primaryColor, width: 2)),
      child: ListTile(
        leading: AppAvatar(),
        title: Text(
          'username',
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'city ' * 20,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
