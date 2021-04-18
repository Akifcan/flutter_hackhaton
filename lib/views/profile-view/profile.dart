import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/string_extensions.dart';
import 'package:help_together/dto/profile.dto.dart';
import 'package:help_together/services/post_service.dart';
import 'package:help_together/services/user_service.dart';
import 'package:help_together/widgets/app_avatar.dart';
import 'package:help_together/widgets/app_comment_card.dart';
import 'package:help_together/widgets/app_post_card.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserService userService = UserService.instance;
  final PostService postService = PostService.instance;
  DocumentSnapshot user;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final ProfileDto args =
          ModalRoute.of(context).settings.arguments as ProfileDto;
      user = await userService.users.doc(args.id).get();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ProfileDto args =
        ModalRoute.of(context).settings.arguments as ProfileDto;

    return Scaffold(
      backgroundColor: Colors.deepOrange,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        child: Icon(Icons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushReplacementNamed('/sign-in');
        },
      ),
      appBar: user != null
          ? AppBar(
              title: Text((this.user['username'] as String).capitalize,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black)),
            )
          : null,
      body: user != null
          ? Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                      child: Container(
                          child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(this.user['avatar']),
                  ))),
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
                            Text(
                              (this.user['username'] as String).capitalize,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: Colors.black),
                            ),
                            SizedBox(height: 20),
                            Expanded(
                                child: PageView(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                  stream: postService.posts
                                      .where('userId', isEqualTo: args.id)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                        itemCount: snapshot.data.docs.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 10),
                                        itemBuilder: (_, index) => AppPostCard(
                                          data: snapshot.data.docs[index],
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: postService.comments
                                      .where('user', isEqualTo: args.id)
                                      .snapshots(),
                                  builder: (_, snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView.separated(
                                        itemCount: snapshot.data.docs.length,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(height: 10),
                                        itemBuilder: (_, index) =>
                                            AppCommentCard(
                                          comment: snapshot.data.docs[index],
                                        ),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    )),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
