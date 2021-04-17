import 'package:flutter/cupertino.dart';
import 'package:help_together/theme/custom_theme.dart';

class CategoryModel {
  final String categoryName;
  final String to;
  final LinearGradient linearGradient;

  CategoryModel({this.categoryName, this.to, this.linearGradient});
}

List<CategoryModel> categories = [
  CategoryModel(
      categoryName: 'Bağış Yap', to: '', linearGradient: gradients[0]),
  CategoryModel(
      categoryName: 'Gönüllü Ol', to: '', linearGradient: gradients[1]),
  CategoryModel(
      categoryName: 'İhtiyaçlar', to: '', linearGradient: gradients[2]),
];
