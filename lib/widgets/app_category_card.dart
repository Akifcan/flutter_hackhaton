import 'package:flutter/material.dart';
import 'package:help_together/models/category_model.dart';

class AppCategoryCard extends StatelessWidget {
  final CategoryModel category;

  const AppCategoryCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            gradient: this.category.linearGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 5), // changes position of shadow
              )
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.red),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(this.category.categoryName,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white)),
        )),
      ),
    );
  }
}
