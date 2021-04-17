import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/string_extensions.dart';
import 'package:help_together/services/user_service.dart';

import 'app_avatar.dart';

class AppCommentCard extends StatefulWidget {
  final QueryDocumentSnapshot comment;

  const AppCommentCard({Key key, this.comment}) : super(key: key);

  @override
  _AppCommentCardState createState() => _AppCommentCardState();
}

class _AppCommentCardState extends State<AppCommentCard> {
  final UserService userService = UserService.instance;
  DocumentSnapshot user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      user = await userService.users.doc(widget.comment['user']).get();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return user != null
        ? Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
            child: ListTile(
              leading: AppAvatar(
                avatarUrl: this.user['avatar'],
              ),
              title: Text(
                (this.user['username'] as String).capitalize,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                (widget.comment['comment'] as String).capitalize,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
