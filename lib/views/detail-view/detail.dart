import 'package:flutter/material.dart';
import 'package:help_together/widgets/app_avatar.dart';
import 'package:help_together/widgets/app_detail_button.dart';
import 'package:help_together/widgets/app_detail_card.dart';

class Detail extends StatefulWidget {
  Detail({Key key}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Column(
          children: [_image, _body],
        ),
      ]),
    );
  }

  Widget get _image => Expanded(
        flex: 2,
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://placekitten.com/408/287'),
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
                Row(
                  children: [
                    AppDetailCard(),
                    AppDetailCard(),
                    AppDetailCard(),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                    'Burada Açıklama Yazısı var Burada Açıklama Yazısı var Burada Açıklama Yazısı var Burada Açıklama Yazısı var.',
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
                      icon: Icons.comment,
                      text: 'Yorum Yap',
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
