class HotSearch {
  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  static List<HotSearch> fromJsonList(List<dynamic> list) {
    return list?.map((map) => fromJson(map))?.toList();
  }

  static HotSearch fromJson(Map<String, dynamic> map) {
    return HotSearch()
      ..id = map['id']
      ..icon = map['icon']
      ..link = map['link']
      ..name = map['name']
      ..order = map['order']
      ..visible = map['visible'];
  }
}
