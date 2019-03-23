// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonData _$CommonDataFromJson<T>(Map<String, dynamic> json) {
  return CommonData()
    ..curPage = json['curPage'] as int
    ..datas = json['datas'] as List
    ..offset = json['offset'] as int
    ..over = json['over'] as bool
    ..pageCount = json['pageCount'] as int
    ..size = json['size'] as int
    ..total = json['total'] as int;
}

Map<String, dynamic> _$CommonDataToJson<T>(CommonData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total
    };

DataResult _$DataResultFromJson(Map<String, dynamic> json) {
  return DataResult()
    ..data = json['data']
    ..errorCode = json['errorCode'] as int
    ..errorMsg = json['errorMsg'] as String;
}

Map<String, dynamic> _$DataResultToJson(DataResult instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg
    };
