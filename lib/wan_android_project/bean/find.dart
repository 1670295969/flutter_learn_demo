class FindItem {
  List<FindItem> children;
  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;

  FindItem();

  static List<FindItem> fromJsonArray(List<dynamic> list) {
    return list?.map((value) {
      return FindItem.fromJson(value);
    })?.toList();
  }

  factory FindItem.fromJson(Map<String, dynamic> map) {
    return FindItem()
      ..children = fromJsonArray(map['children'])
      ..courseId = map["courseId"]
      ..id = map['id']
      ..name = map['name']
      ..order = map['order']
      ..parentChapterId = map['parentChapterId']
      ..userControlSetTop = map['userControlSetTop']
      ..visible = map['visible'];
  }
}

