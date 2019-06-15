import 'dart:convert';

import 'package:f_douban_movie/bean/hot_movie_data.dart';
import 'package:http/http.dart' as http;

class DouBanNetStorage{

  // ignore: missing_return
  static Future<List<HotMovieData>> reqHotMovieList(city) async {
    List<HotMovieData> serverDataList = new List();
    var response = await http.get(
        'https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=$city&start=0&count=10&client=&udid=');
    //成功获取数据
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      for (dynamic data in responseJson['subjects']) {
        HotMovieData hotMovieData = HotMovieData.fromJson(data);
        serverDataList.add(hotMovieData);
      }
      return serverDataList;
    }
  }





}