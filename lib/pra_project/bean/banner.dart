//@JsonSerializable()
import 'package:flutter_app/pra_project/utils/array_utils.dart';

class ArticleBanner {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  ArticleBanner();

  static List<ArticleBanner> fromJsonArray(List<dynamic> array) {
    return array?.map((map) {
      return ArticleBanner.fromJson(map);
    })?.toList();

//      ArrayUtils.convertToList(array, (map) {
//      return ArticleBanner.fromJson(map);
//    });
//    return
  }

  factory ArticleBanner.fromJson(Map<String, dynamic> map) {
    return ArticleBanner()
      ..desc = map["desc"]
      ..id = map["id"]
      ..imagePath = map['imagePath']
      ..isVisible = map['isVisible']
      ..order = map['order']
      ..title = map['title']
      ..type = map['type']
      ..url = map['url'];
  }
}
