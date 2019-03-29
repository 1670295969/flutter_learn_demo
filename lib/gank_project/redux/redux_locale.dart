import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

final combineLocaleReducer = combineReducers<Locale>([
  TypedReducer<Locale, RefreshLocalAction>(_refreshLocale),
]);

Locale _refreshLocale(Locale locale, RefreshLocalAction action) {
  locale = action.locale;
  return locale;
}

class RefreshLocalAction {
  final Locale locale;

  RefreshLocalAction(this.locale);
}
