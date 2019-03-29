import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/constant/locale/locale_base.dart';
import 'package:flutter_app/gank_project/constant/locale/locale_en.dart';
import 'package:flutter_app/gank_project/constant/locale/locale_zh.dart';


///自定义多语言实现
class GankLocalizations {
  final Locale locale;

  GankLocalizations(this.locale);

  static Map<String, StringBase> _localizedValues = {
    'en': StringEn(),
    'zh': StringZh(),
  };

  StringBase get currentLocalized {
    return _localizedValues[locale.languageCode];
  }

  static GankLocalizations of(BuildContext context) {
    return Localizations.of(context, GankLocalizations);
  }
}
