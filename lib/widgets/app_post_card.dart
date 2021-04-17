import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_together/widgets/app_post_icon.dart';

class AppPostCard extends StatelessWidget {
  final DocumentSnapshot data;

  const AppPostCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.data.id);
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Image.network(
                this.data['images'][0],
                height: MediaQuery.of(context).size.height * 0.4,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Text(
                      this.data['content']['title'] + ' ' + this.data['type'],
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: Colors.white)),
                ),
              )
            ],
          )),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppPostIcon(icon: Icons.chevron_right, detail: this.data),
                AppPostIcon(icon: FontAwesomeIcons.paw),
                AppPostIcon(icon: Icons.save)
              ],
            ),
          )
        ],
      ),
    );
  }
}
