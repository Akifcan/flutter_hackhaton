import 'package:flutter/material.dart';
import 'package:help_together/models/category_model.dart';
import 'package:help_together/widgets/app_category_card.dart';
import 'package:help_together/widgets/app_header.dart';
import 'package:help_together/widgets/location_card.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  flex: 1,
                  child: ListView.separated(
                      separatorBuilder: (_, __) => SizedBox(height: 10),
                      itemCount: 10,
                      itemBuilder: (_, __) => Container(
                            decoration: BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius: BorderRadius.circular(20)),
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              children: [
                                Expanded(
                                    child: Stack(
                                  children: [
                                    Image.network(
                                      'https://placekitten.com/408/287',
                                      fit: BoxFit.cover,
                                    )
                                  ],
                                )),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        color: Colors.white,
                                        iconSize: 35,
                                        icon: Icon(Icons.favorite),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        color: Colors.white,
                                        iconSize: 35,
                                        icon: Icon(Icons.favorite),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        color: Colors.white,
                                        iconSize: 35,
                                        icon: Icon(Icons.favorite),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )))
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
          itemBuilder: (_, index) =>
              AppCategoryCard(category: categories[index]),
        ),
      );
}
