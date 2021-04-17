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
      type: 'donate',
      categoryName: 'Bağış Yap',
      to: '',
      linearGradient: gradients[0]),
  CategoryModel(
      type: 'volunteer',
      categoryName: 'Gönüllü Ol',
      to: '',
      linearGradient: gradients[1]),
  CategoryModel(
      type: 'pet',
      categoryName: 'İhtiyaçlar',
      to: '',
      linearGradient: gradients[2]),
];
