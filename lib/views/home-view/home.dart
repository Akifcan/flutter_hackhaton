import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:help_together/core/storage.dart';
import 'package:help_together/models/category_model.dart';
import 'package:help_together/services/post_service.dart';
import 'package:help_together/widgets/app_category_card.dart';
import 'package:help_together/widgets/app_header.dart';
import 'package:help_together/widgets/app_post_card.dart';
import 'package:help_together/widgets/location_card.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<QueryDocumentSnapshot> posts;
  List<QueryDocumentSnapshot> corePosts;
  final PostService postService = PostService.instance;

  listByCategory(String categoryName) {
    setState(() {
      if (categoryName == 'all') {
        posts = corePosts;
      } else {
        posts = corePosts
            .where((element) => element['type'] == categoryName)
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      final postList = await postService.posts
          .orderBy('time', descending: false)
          .where('province', isEqualTo: Storage.getString('location'))
          .get();
      setState(() {
        posts = postList.docs;
        corePosts = postList.docs;
      });
      print(posts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      floatingActionButton: _fab,
      body: Column(
        children: [
          AppHeader(),
          _body,
        ],
      ),
    );
  }

  Widget get _body => Expanded(
        flex: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Color(0xffe3e3e3)),
          child: Column(
            children: [
              LocationCard(),
              SizedBox(height: 20),
              _categories,
              SizedBox(height: 20),
              Expanded(
                  child: posts != null
                      ? ListView.separated(
                          separatorBuilder: (_, __) => SizedBox(height: 10),
                          itemCount: posts.length,
                          itemBuilder: (_, index) => AppPostCard(
                                data: posts[index],
                              ))
                      : Center(child: CircularProgressIndicator()))
            ],
          ),
        ),
      );

  Widget get _categories => Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(width: 20),
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) => AppCategoryCard(
            category: categories[index],
            voidCallback: () => listByCategory(categories[index].type),
          ),
        ),
      );

  Widget get _fab => FloatingActionButton(
        elevation: 5,
        onPressed: () => Navigator.of(context).pushNamed('/create-post'),
        backgroundColor: Colors.indigo,
        child: Wrap(
          children: [
            Icon(
              Icons.add,
              size: 40,
            )
          ],
        ),
      );
}
