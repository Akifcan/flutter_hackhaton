import 'package:flutter/cupertino.dart';
import 'package:help_together/theme/custom_theme.dart';

class CategoryModel {
  final String categoryName;
  final String to;
  final String type;
  final LinearGradient linearGradient;

  CategoryModel({this.type, this.categoryName, this.to, this.linearGradient});
}

List<CategoryModel> categories = [
  CategoryModel(
      type: 'all', categoryName: 'Tümü', to: '', linearGradient: gradients[1]),
  CategoryModel(
      type: 'donate', categoryName: 'Bağış Yap', linearGradient: gradients[0]),
  CategoryModel(
      type: 'volunteer',
      categoryName: 'Gönüllü Ol',
      linearGradient: gradients[1]),
  CategoryModel(
      type: 'pet', categoryName: 'İhtiyaçlar', linearGradient: gradients[2]),
];
