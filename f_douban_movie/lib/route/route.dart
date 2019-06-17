

import 'package:f_douban_movie/city/city.dart';
import 'package:flutter/material.dart';

class RouteUtils{

  static Map<String, WidgetBuilder> routeMap(){

    return {
      '/Citys': (context) => CityWidget(),
    };


  }

  static Future pushedToCity(context,currentCity) {
    return Navigator.pushNamed(context, "/Citys",arguments: currentCity);
  }


}

