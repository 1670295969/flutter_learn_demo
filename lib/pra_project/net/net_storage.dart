import 'package:flutter_app/pra_project/bean/banner.dart';
import 'package:flutter_app/pra_project/bean/base_result.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';
import 'package:flutter_app/pra_project/net/net_utils.dart';

class NetStorage {
//获取banner列表
  static Future<List<ArticleBanner>> getBannerList() async {
    var dataResult = await NetProxy.getDataResult(AppApi.BANNER);
    return ArticleBanner.fromJsonArray(dataResult.data);
  }

  static Future<CommonData> getArticleList(int page) async {
    var data = await NetProxy.get(AppApi.ARTICLE_LIST + "$page/json");
    var dataResult = DataResult.fromJson(data);
    var pageData = CommonData.fromJson(dataResult.data);
    return pageData;
  }

  ///**
// * {
//    "data": {
//    "chapterTops": [],
//    "collectIds": [
//    7445,
//    8105,
//    8104,
//    8027,
//    8025,
//    8023
//    ],
//    "email": "",
//    "icon": "",
//    "id": 6142,
//    "password": "",
//    "token": "",
//    "type": 0,
//    "username": "canhuah"
//    },
//    "errorCode": 0,
//    "errorMsg": ""
//    }
// */
  static Future<DataResult> login(String userName, String password) async {
    return NetProxy.postDataResult(AppApi.LOGIN,
        params: {"username": userName, "password": password});
  }

  //返回数据样式和login一样
  static Future<DataResult> register(
      String userName, String password, String rePassword) {
    return NetProxy.postDataResult(AppApi.REGISTER, params: {
      "username": userName,
      "password": password,
      "repassward": rePassword
    });
  }

  static Future<DataResult> getFindList(){
    return NetProxy.getDataResult(AppApi.TREE);
  }

  //获取文章列表
  static Future<CommonData> getArticleListWithTagId(int page,int id) async {
    var map = {"cid":id};
    var data = await NetProxy.get(AppApi.ARTICLE_LIST + "$page/json",params: map);
    var dataResult = DataResult.fromJson(data);
    var pageData = CommonData.fromJson(dataResult.data);
    return pageData;
  }

  //取消收藏
  static Future<DataResult> unCollect(int id){
    return NetProxy.postDataResult(AppApi.UNCOLLECT_ORIGINID +"$id/json");
  }

  //收藏
  static Future<DataResult> toCollect(int id){
    return NetProxy.postDataResult(AppApi.COLLECT +"$id/json");
  }






}
