//import 'package:json_annotation/json_annotation.dart';
//
part 'base_result.g.dart';

//@JsonSerializable()
class CommonData {
  int curPage;

  List<dynamic> datas;

  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  CommonData();

  static List<CommonData> fromJsonArray(List<dynamic> array) {
    return array?.map((map) {
      return CommonData.fromJson(map);
    })?.toList();
  }

  factory CommonData.fromJson(Map<String, dynamic> map) =>
      _$CommonDataFromJson(map);

  Map<String, dynamic> toJson() => _$CommonDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}

//@JsonSerializable()
class DataResult {
  dynamic data;
  int errorCode;
  String errorMsg;
  DataResult();

  factory DataResult.fromJson(Map<String, dynamic> map) =>
      _$DataResultFromJson(map);

  Map<String, dynamic> toJson() => _$DataResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
