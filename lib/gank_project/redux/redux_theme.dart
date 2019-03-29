import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final combineThemeDataReducer = combineReducers<ThemeData>(
    [TypedReducer<ThemeData, RefreshThemeData>(_updateThemeData)]);

ThemeData _updateThemeData(ThemeData themeData, action) {
  themeData = action.themeData;
  return themeData;
}

class RefreshThemeData {
  final ThemeData themeData;

  RefreshThemeData(this.themeData);
}
