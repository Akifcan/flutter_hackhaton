import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/services/language_service.dart';
import 'package:help_together/services/post_service.dart';
import 'package:help_together/views/detail-view/detail.dart';
import 'package:help_together/widgets/app_post_icon.dart';
import 'package:help_together/core/string_extensions.dart';

class AppPostCard extends StatelessWidget {
  AppPostCard({Key key, this.data}) : super(key: key);
  final DocumentSnapshot data;
  final PostService postService = PostService.instance;

  deletePost(context) {
    if (Storage.getString('userid') == data['userId']) {
      return showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title:
                    Text(LanguageService.instance.translateWord('deletePost')),
                content: Text(LanguageService.instance
                    .translateWord('deleteCommentPost')),
                actions: [
                  ElevatedButton(
                      child:
                          Text(LanguageService.instance.translateWord('yes')),
                      style: ElevatedButton.styleFrom(primary: Colors.red[900]),
                      onPressed: () {
                        postService.deletePost(this.data.id);
                        Navigator.of(context).pop();
                      }),
                  ElevatedButton(
                    child: Text(LanguageService.instance.translateWord('no')),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData getIcon() {
      if (this.data['type'] == 'pet') {
        return FontAwesomeIcons.paw;
      }
      if (this.data['type'] == 'volunteer') {
        return FontAwesomeIcons.user;
      } else {
        return FontAwesomeIcons.moneyCheck;
      }
    }

    return GestureDetector(
      onLongPress: () => deletePost(context),
      child: Container(
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  color: Colors.grey[900].withOpacity(.4),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                        (this.data['content']['title'] as String).capitalize,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(color: Colors.white)),
                  ),
                ),
                Positioned(
                    left: 15,
                    top: 15,
                    child: Icon(
                      getIcon(),
                      color: Colors.white,
                    )),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppPostIcon(
                    icon: Icons.chevron_right,
                    detail: this.data,
                    voidCallback: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => Detail(detail: this.data))),
                  ),
                  AppPostIcon(
                      icon: Icons.favorite,
                      voidCallback: () async {
                        await FlutterShare.share(
                          title: this.data['content']['title'],
                          text: this.data['content']['description'],
                        );
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
