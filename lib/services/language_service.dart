import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:help_together/core/storage.dart';

class LanguageService {
  LanguageService._privateConstructor();
  static final LanguageService _instance =
      LanguageService._privateConstructor();
  static LanguageService get instance => _instance;

  Map language = {};

  translate() async {
    final String preferredLanguage = Storage.getString('language');
    final result = await rootBundle
        .loadString('assets/translations/$preferredLanguage.json');
    final data = jsonDecode(result);
    language = data;
    print(language);
  }

  translateWord(String key) {
    if (this.language[key] != null) {
      return this.language[key];
    } else {
      return '';
    }
  }
}
