import 'package:flutter/material.dart';

class NavigatorUtils {
  static const String ROUTE_SPLASH_PAGE = "/";

  static const String ROUTE_HOME = "home";

  static const String ROUTE_SEARCH = "search";

  static const String ROUTE_SETTING = "setting";
  static const String ROUTE_LOGIN = "login";
  static const String ROUTE_ABOUT = "about";

  static pushReplacementNamed(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  static pushNamed(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  static goHome(BuildContext context) {
    pushNamed(context, ROUTE_HOME);
  }

  static goSearch(BuildContext context){
    pushNamed(context, ROUTE_SEARCH);
  }

  static goSetting(BuildContext context){
    pushNamed(context, ROUTE_SETTING);
  }

  static goLogin(BuildContext context){
    pushNamed(context, ROUTE_LOGIN);
  }

  static goAbout(BuildContext context){
    pushNamed(context, ROUTE_ABOUT);
  }









}
