import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/bean/github_user.dart';
import 'package:flutter_app/gank_project/redux/redux_locale.dart';
import 'package:flutter_app/gank_project/redux/redux_theme.dart';
import 'package:flutter_app/gank_project/redux/redux_user.dart';

class AppState {
  User userInfo;
  ThemeData themeData;
  Locale locale;
  Locale platformLocale;

  AppState({this.userInfo, this.locale, this.themeData});
}

AppState appReducer(AppState state, action) {
  return AppState(
    userInfo: combineUserReducer(state.userInfo, action),
    themeData: combineThemeDataReducer(state.themeData, action),
    locale: combineLocaleReducer(state.locale, action),
  );
}
