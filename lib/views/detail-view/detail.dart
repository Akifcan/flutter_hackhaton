import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_together/services/user_service.dart';
import 'package:help_together/views/detail-view/comments.dart';
import 'package:help_together/widgets/app_avatar.dart';
import 'package:help_together/widgets/app_detail_button.dart';
import 'package:help_together/widgets/app_detail_card.dart';

class Detail extends StatefulWidget {
  final DocumentSnapshot detail;

  Detail({Key key, this.detail}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final UserService users = UserService.instance;
  DocumentSnapshot user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      user = await users.users.doc(widget.detail['userId']).get();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: user != null
          ? Stack(children: [
              Column(
                children: [_image, _body],
              ),
            ])
          : Center(child: CircularProgressIndicator()),
    );
  }

  Widget get _image => Expanded(
        flex: 2,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.detail['images'][0]),
                    fit: BoxFit.cover))),
      );

  Widget get _body => Transform.translate(
        offset: Offset(0, -30),
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(40), topLeft: Radius.circular(40)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: AppAvatar(
                    avatarUrl: user['avatar'].toString(),
                  ),
                  title: Text(
                    user['username'].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  subtitle: Text(
                    user['city'],
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                if (widget.detail['type'] == 'pet')
                  Row(
                    children: [
                      AppDetailCard(
                          text: widget.detail['content']['age'].toString()),
                      AppDetailCard(
                          text: widget.detail['content']['gender'].toString() ==
                                  'male'
                              ? 'Erkek'
                              : 'Dişi'),
                    ],
                  ),
                SizedBox(height: 20),
                Text(widget.detail['content']['title'],
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(color: Colors.black)),
                Text(widget.detail['content']['description'],
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(color: Colors.black)),
                SizedBox(height: 20),
                Row(
                  children: [
                    AppDetailButton(icon: Icons.map, text: 'Konum'),
                    SizedBox(width: 20),
                    AppDetailButton(
                      voidCallback: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => Comments(
                                  id: widget.detail.id,
                                  title: widget.detail['content']['title']))),
                      icon: Icons.comment,
                      text: 'Yorumlar',
                      color: Colors.red[900],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
