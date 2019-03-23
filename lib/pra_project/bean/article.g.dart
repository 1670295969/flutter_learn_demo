// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleItem _$ArticleItemFromJson(Map<String, dynamic> json) {
  return ArticleItem()
    ..apkLink = json['apkLink'] as String
    ..author = json['author'] as String
    ..chapterId = json['chapterId'] as int
    ..chapterName = json['chapterName'] as String
    ..collect = json['collect'] as bool
    ..courseId = json['courseId'] as int
    ..desc = json['desc'] as String
    ..envelopePic = json['envelopePic'] as String
    ..fresh = json['fresh'] as bool
    ..id = json['id'] as int
    ..link = json['link'] as String
    ..niceDate = json['niceDate'] as String
    ..origin = json['origin'] as String
    ..projectLink = json['projectLink'] as String
    ..publishTime = json['publishTime'] as int
    ..superChapterId = json['superChapterId'] as int
    ..superChapterName = json['superChapterName']
    ..tags = (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : ArticleTag.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..title = json['title'] as String
    ..type = json['type'] as int
    ..userId = json['userId'] as int
    ..visible = json['visible'] as int
    ..zan = json['zan'] as int;
}

Map<String, dynamic> _$ArticleItemToJson(ArticleItem instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'tags': instance.tags,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan
    };

ArticleTag _$ArticleTagFromJson(Map<String, dynamic> json) {
  return ArticleTag()
    ..name = json['name'] as String
    ..url = json['url'] as String;
}

Map<String, dynamic> _$ArticleTagToJson(ArticleTag instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
