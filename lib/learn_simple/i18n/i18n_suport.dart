import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'language.dart';

class DemoLocalizations {
  final Locale locale;

  DemoLocalizations(this.locale);

  static Map<String,BaseLanguage> _localStr = {
    "zh":ChLanguage(),
    "en":EnLanguage(),
  };


  BaseLanguage get currentLocalized {
    return _localStr[locale.languageCode];
  }

  static DemoLocalizations of(BuildContext context){
    return Localizations.of(context, DemoLocalizations);
  }

}

class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['zh', 'en'].contains(locale.languageCode);
  }




  @override
  Future<DemoLocalizations> load(Locale locale) {
    return SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }

  static DemoLocalizationsDelegate delegate = DemoLocalizationsDelegate();
}
