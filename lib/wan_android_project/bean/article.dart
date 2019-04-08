import 'package:flutter_app/wan_android_project/bean/base_result.dart';
//import 'package:json_annotation/json_annotation.dart';
//import 'package:json_serializable/json_serializable.dart';

part 'article.g.dart';
//json 序列化方案
//一次性生成                                                               `--delete-conflicting-outputs`
//通过在我们的项目根目录下运行flutter packages pub run build_runner build，我们可以在需要时为我们的model生成json序列化代码。
// 这触发了一次性构建，它通过我们的源文件，挑选相关的并为它们生成必要的序列化代码。
//
//虽然这非常方便，但如果我们不需要每次在model类中进行更改时都要手动运行构建命令的话会更好。
//
//持续生成
//使用_watcher_可以使我们的源代码生成的过程更加方便。它会监视我们项目中文件的变化，并在需要时自动构建必要的文件。我们可以通过flutter packages pub run
//build_runner watch在项目根目录下运行来启动_watcher_。

//@JsonSerializable()
class ArticleItem {
  String apkLink;
  String author;
  int chapterId;
  String chapterName;
  bool collect;
  int courseId;
  String desc; //
  String envelopePic;
  bool fresh;
  int id;
  String link;
  String niceDate;
  String origin;
  String projectLink;
  int publishTime;
  int superChapterId;
  String superChapterName;
  List<ArticleTag> tags;
  String title;
  int type;
  int userId;
  int visible;
  int zan;

  ArticleItem();

  factory ArticleItem.fromJson(Map<String,dynamic> map) =>_$ArticleItemFromJson(map);

  Map<String,dynamic> toJson() => _$ArticleItemToJson(this);

   static List<ArticleItem> fromJsonArray(List<dynamic> arr){
    return arr?.map((json){
      return ArticleItem.fromJson(json);
    })?.toList();
  }





}

//name: "项目",
//  url: "/project/list/1?cid=328"
//@JsonSerializable()
class ArticleTag {
  String name;
  String url;
  ArticleTag();
  factory ArticleTag.fromJson(Map<String, dynamic> map) => _$ArticleTagFromJson(map);
  Map<String,dynamic> toJson() => _$ArticleTagToJson(this);
}

//@JsonSerializable()
//class ArticleData extends CommonData<ArticleItem>{
//  ArticleData();
//  factory ArticleData.fromJson(Map<String,dynamic> map) => _$ArticleDataFromJson(map);
//  Map<String,dynamic> toJson() => _$ArticleDataToJson(this);
//}
//
//
//@JsonSerializable()
//class ArticleResult extends DataResult<ArticleData>{
//  ArticleResult();
//  factory ArticleResult.fromJson(Map<String,dynamic> map) => _$ArticleResultFromJson(map);
//  Map<String,dynamic> toJson() => _$ArticleResultToJson(this);
//}



