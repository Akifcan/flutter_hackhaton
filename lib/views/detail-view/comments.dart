import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_together/services/language_service.dart';
import 'package:help_together/services/post_service.dart';
import 'package:help_together/widgets/app_comment_card.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:help_together/core/string_extensions.dart';

class Comments extends StatefulWidget {
  final String id;
  final String title;
  Comments({Key key, this.id, this.title}) : super(key: key);

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<Asset> images = [];
  PostService postService = PostService.instance;
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  String comment;

  createComment() async {
    if (key.currentState.validate()) {
      key.currentState.save();
      await postService.createComment(comment, widget.id, images);
      print('ok');
    }
  }

  chooseImages(state) async {
    List<Asset> resultList;
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on Exception catch (e) {
      print(e);
    }

    state(() {
      images = resultList;
    });
  }

  removeImage(int index, state) {
    state(() {
      images.removeAt(index);
    });
  }

  showCommentDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) => StatefulBuilder(
            builder: (context, setState) => SingleChildScrollView(
                  child: Container(
                    color: Color(0xffdedede),
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Center(
                        child: Form(
                          key: key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextFormField(
                                onSaved: (val) => setState(() => comment = val),
                                validator: (val) {
                                  if (val.length > 250) {
                                    return "Yorumunuz çok uzun";
                                  }
                                  if (val.length < 5) {
                                    return "Yorumunuz çok kısa";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    suffixIcon: Wrap(
                                      children: [
                                        IconButton(
                                            color: Colors.black,
                                            icon: Icon(Icons.image),
                                            onPressed: () {
                                              chooseImages(setState);
                                            }),
                                        IconButton(
                                          color: Colors.black,
                                          icon: Icon(Icons.chevron_right),
                                          onPressed: createComment,
                                        ),
                                      ],
                                    ),
                                    hintText: LanguageService.instance
                                        .translateWord('createComment')),
                              ),
                              SizedBox(height: 50),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: images.length > 0
                                    ? ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        separatorBuilder: (_, __) =>
                                            SizedBox(width: 10),
                                        itemCount: images.length,
                                        itemBuilder: (_, index) =>
                                            GestureDetector(
                                              onLongPress: () =>
                                                  removeImage(index, setState),
                                              child: AssetThumb(
                                                  asset: images[index],
                                                  height: 50,
                                                  width: 50),
                                            ))
                                    : SizedBox(
                                        height: 250,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdedede),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(LanguageService.instance.translateWord('createComment')),
        backgroundColor: Colors.deepOrange,
        icon: Icon(Icons.comment),
        onPressed: showCommentDialog,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text((widget.title as String).capitalize,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.black)),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: postService.comments
                      .where('id', isEqualTo: widget.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemCount: snapshot.data.docs.length,
                          separatorBuilder: (_, __) => SizedBox(height: 10),
                          itemBuilder: (_, index) => AppCommentCard(
                                comment: snapshot.data.docs[index],
                              ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
