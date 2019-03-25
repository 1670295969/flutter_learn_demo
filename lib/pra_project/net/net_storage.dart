import 'package:flutter_app/pra_project/bean/banner.dart';
import 'package:flutter_app/pra_project/bean/base_result.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';
import 'package:flutter_app/pra_project/net/net_utils.dart';

class NetStorage {
//获取banner列表
  static Future<List<ArticleBanner>> getBannerList() async {
    var data = await NetProxy.get(AppApi.BANNER);
    var dataResult = DataResult.fromJson(data);
    return ArticleBanner.fromJsonArray(dataResult.data);
  }

  static Future<CommonData> getArticleList(int page) async {
    var data = await NetProxy.get(AppApi.ARTICLE_LIST + "$page/json");
    var dataResult = DataResult.fromJson(data);
    var pageData = CommonData.fromJson(dataResult.data);
    return pageData;
  }
}
