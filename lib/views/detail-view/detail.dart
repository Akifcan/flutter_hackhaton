import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_together/dto/donate.dto.dart';
import 'package:help_together/dto/profile.dto.dart';
import 'package:help_together/services/language_service.dart';
import 'package:help_together/services/user_service.dart';
import 'package:help_together/views/detail-view/comments.dart';
import 'package:help_together/views/post-view/images.dart';
import 'package:help_together/views/post-view/map_view.dart';
import 'package:help_together/widgets/app_avatar.dart';
import 'package:help_together/widgets/app_detail_button.dart';
import 'package:help_together/widgets/app_detail_card.dart';
import 'package:help_together/core/string_extensions.dart';
import 'package:help_together/widgets/app_donate_info_card.dart';

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
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Images(
                    imageList: widget.detail['images'],
                    lat: widget.detail['content']['lat'],
                    long: widget.detail['content']['long'],
                  ))),
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.detail['images'][0]),
                      fit: BoxFit.cover))),
        ),
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
                  onTap: () => Navigator.of(context).pushNamed('/profile',
                      arguments: ProfileDto(id: widget.detail['userId'])),
                  leading: AppAvatar(
                    avatarUrl: user['avatar'].toString(),
                  ),
                  title: Text(
                    user['username'].toString().capitalize,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                  subtitle: Text(
                    (user['city'] as String).capitalize,
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
                        text: Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          children: [
                            Text(LanguageService.instance.translateWord('age'),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: Colors.white)),
                            Text(
                              widget.detail['content']['age'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      AppDetailCard(
                          text: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 20,
                        children: [
                          Icon(FontAwesomeIcons.venusMars,
                              size: 30, color: Colors.white),
                          Text(
                            widget.detail['content']['gender'].toString() ==
                                    'male'
                                ? 'Erkek'
                                : 'Dişi',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.white),
                          )
                        ],
                      )),
                    ],
                  ),
                SizedBox(height: 20),
                if (widget.detail['type'] == 'donate' &&
                    widget.detail['content']['available'] >=
                        widget.detail['content']['goal'])
                  Text((widget.detail['content']['title'] as String).capitalize,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(color: Colors.black)),
                if (widget.detail['type'] == 'donate')
                  AppDonateInfo(
                    goal: widget.detail['content']['goal'],
                    available: widget.detail['content']['available'],
                  ),
                Text(
                    (widget.detail['content']['description'] as String)
                        .capitalize,
                    textAlign: TextAlign.justify,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(color: Colors.black)),
                SizedBox(height: 20),
                Row(
                  children: [
                    if (widget.detail['type'] == 'donate' &&
                        widget.detail['content']['available'] <
                            widget.detail['content']['goal'])
                      AppDetailButton(
                        icon: Icons.money,
                        text: 'Bağış Yap',
                        voidCallback: () =>
                            Navigator.of(context).pushNamed('/donate',
                                arguments: DonateDto(
                                  description: widget.detail['content']
                                      ['description'],
                                  title: widget.detail['content']['title'],
                                  goal: widget.detail['content']['goal'],
                                )),
                      ),
                    if (widget.detail['type'] != 'donate')
                      AppDetailButton(
                        icon: Icons.map,
                        text:
                            LanguageService.instance.translateWord('location'),
                        voidCallback: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (_) => MapView(
                                    lat: widget.detail['content']['lat'],
                                    long: widget.detail['content']['long']))),
                      ),
                    SizedBox(width: 20),
                    AppDetailButton(
                      voidCallback: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => Comments(
                                  id: widget.detail.id,
                                  title: widget.detail['content']['title']))),
                      icon: Icons.comment,
                      text:
                          LanguageService.instance.translateWord("allComments"),
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
