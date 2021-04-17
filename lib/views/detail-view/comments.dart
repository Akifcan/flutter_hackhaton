import 'package:flutter/material.dart';
import 'package:help_together/widgets/app_avatar.dart';

class Comments extends StatefulWidget {
  Comments({Key key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdedede),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.1,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
