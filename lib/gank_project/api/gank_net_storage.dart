

import 'package:dio/dio.dart';
import 'package:flutter_app/gank_project/api/gank_api.dart';
import 'package:flutter_app/gank_project/net/http_manager.dart';
import 'package:flutter_app/gank_project/net/http_response.dart';

class GankNetStorage{



  ///获取最新一天的数据
  static getTodayData() async {
    NetResponse response = await HttpManager.get(GankApi.API_TODAY);
    return response.data;
  }

  ///获取指定日期的数据 [date:指定日期]
  static getSpecialDayData(String date) async {
    NetResponse response =
    await HttpManager.get(GankApi.API_SPECIAL_DAY + date.replaceAll("-", "/"));
    return response.data;
  }

  ///获取分类数据 [category:分类, page: 页数, count:每页的个数]
  static getCategoryData(String category, int page, {count = 20}) async {
    String url = GankApi.API_DATA + category + "/$count/$page";
    NetResponse response = await HttpManager.get(url);
    return response.data;
  }

  ///获取所有的历史干货日期.
  static getHistoryDateData() async {
    NetResponse response = await HttpManager.get(GankApi.API_HISTORY);
    return response.data['results'];
  }

  ///搜索[简易搜索，后面拆分页]
  static searchData(String search) async {
    NetResponse response = await HttpManager.get(
        GankApi.API_SEARCH + "/$search/category/all/count/50/page/1");
    return response.data['results'];
  }

  ///提交干货[url:干货地址,desc:干货描述,type:干货类型,debug:true为测试提交，false为正式提交
  static submitData(url, desc, who, type, {debug = false}) async {
    FormData formData = FormData.from({
      'url': url,
      'desc': desc,
      'who': who,
      'type': type,
      'debug': debug,
    });
    NetResponse response =
    await HttpManager.post(GankApi.API_SUBMIT, params: formData);
    return response.data;
  }

  ///获取所有的历史干货.
  static getHistoryContentData(int page, {count = 20}) async {
    NetResponse response =
    await HttpManager.get(GankApi.API_HISTORY_CONTENT + '/$count/$page');
    return response.data['results'];
  }


}