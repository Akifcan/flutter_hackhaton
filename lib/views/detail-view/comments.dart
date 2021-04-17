import 'package:flutter/material.dart';
import 'package:help_together/widgets/app_comment_card.dart';
import 'package:help_together/widgets/app_comment_header.dart';

class Comments extends StatefulWidget {
  Comments({Key key}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  showCommentDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              color: Color(0xffdedede),
              height: MediaQuery.of(context).size.height * 0.7,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
                child: Center(
                  child: Column(
                    children: [
                      AppCommentHeader(),
                      SizedBox(height: 10),
                      Form(
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                              suffixIcon: Wrap(
                                children: [
                                  IconButton(
                                    tooltip: 'Resim Yükle',
                                    icon: Icon(Icons.camera),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    tooltip: 'Paylaş',
                                    icon: Icon(Icons.chevron_right),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              filled: true),
                        ),
                      ),
                      Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (_, __) => SizedBox(width: 5),
                              itemBuilder: (_, __) => Image.network(
                                  'https://placekitten.com/96/140')))
                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdedede),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Yorum Yap'),
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.comment),
        onPressed: showCommentDialog,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCommentHeader(),
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                  itemCount: 20,
                  separatorBuilder: (_, __) => SizedBox(height: 10),
                  itemBuilder: (_, __) => AppCommentCard()),
            )
          ],
        ),
      ),
    );
  }
}
