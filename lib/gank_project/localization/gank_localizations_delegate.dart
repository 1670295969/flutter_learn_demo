

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/localization/gank_localizations.dart';

class GankLocalizationsDelegate extends LocalizationsDelegate<GankLocalizations>{
  @override
  bool isSupported(Locale locale) {
    ///支持中文和英语
    return ['en', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<GankLocalizations> load(Locale locale) {
    return SynchronousFuture<GankLocalizations>(GankLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<GankLocalizations> old) {
    return false;
  }

  ///全局静态的代理
  static GankLocalizationsDelegate delegate = GankLocalizationsDelegate();

}

