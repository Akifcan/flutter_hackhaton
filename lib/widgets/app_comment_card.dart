import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/core/string_extensions.dart';
import 'package:help_together/dto/profile.dto.dart';
import 'package:help_together/services/post_service.dart';
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
  final PostService postService = PostService.instance;
  DocumentSnapshot user;

  deleteComment(String id) {
    print(id);
    if (id == Storage.getString('userid')) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text('Yorum Sil 🗑'),
                content: Text('Bu yorumu silmek istediğinizden emin misiniz?'),
                actions: [
                  ElevatedButton(
                      child: Text('Evet Sil'),
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                      onPressed: () {
                        postService.deleteComment(widget.comment.id);
                        Navigator.of(context).pop();
                      }),
                  ElevatedButton(
                    child: Text('Geri Dön'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    }
  }

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
    if (user != null) {
      return GestureDetector(
        onLongPress: () => deleteComment(user.id),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 2)),
          child: ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed('/profile', arguments: ProfileDto(id: this.user.id)),
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
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
