import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/widgets/app_avatar.dart';
import 'package:help_together/core/string_extensions.dart';

class AppHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        child: Container(
          color: Colors.deepOrange,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Text(FirebaseAuth.instance.currentUser.displayName,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w900, color: Colors.white)),
                  ),
                  Transform.translate(
                      offset: Offset(0, 10),
                      child: AppAvatar(
                          avatarUrl:
                              FirebaseAuth.instance.currentUser.photoURL))
                ],
              ),
              Text((Storage.getString('location') as String).capitalize,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
