import 'package:flutter/material.dart';
import 'package:help_together/models/category_model.dart';
import 'package:help_together/services/language_service.dart';

class AppCategoryCard extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback voidCallback;

  const AppCategoryCard({Key key, this.category, this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.voidCallback,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blueGrey[500],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 20,
              offset: Offset(0, 5), // changes position of shadow
            )
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
                LanguageService.instance.translateWord(this.category.type),
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white))),
      ),
    );
  }
}
