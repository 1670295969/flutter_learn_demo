import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/wan_android_project/bean/base_result.dart';
import 'package:flutter_app/wan_android_project/login/login_mamager.dart';
import 'package:flutter_app/wan_android_project/net/base_api.dart';
import 'package:flutter_app/wan_android_project/net/net_exceptions.dart';
import 'package:flutter_app/wan_android_project/utils/sp_utils.dart';

typedef OnSuccessCallBack(dynamic json);

typedef OnErrorCallBack(int errorCode, String errorMessage);

class _HttpHolder {
  static Dio dio = Dio();
}

class NetProxy {
  static NetException _errorException(int netCode) {
    return NetException(netCode, "请求数据错误");
  }

  static NetException _errorExceptionWithMsg(int netCode, String message) {
    if (netCode == -1001) {
      LoginManager.clearLoginInfo().then((value) {});
    }
    return NetException(netCode, message);
  }

  static Future<List<Cookie>> _getCookie() async {
    String cookieStr = await SpUtils.get("Cookie");

    if (cookieStr == null || cookieStr.isEmpty) {
      return null;
    }

    List list = json.decode(cookieStr);

    return list.map((value) {
      return Cookie.fromSetCookieValue(value.toString().split(";")[0]);
    }).toList();
  }

  static Future<String> _getCookie2() async {
    String cookieStr = await SpUtils.get("Cookie");

    if (cookieStr == null || cookieStr.isEmpty) {
      return null;
    }

    List<dynamic> list = json.decode(cookieStr);
    String cookie = "";
     list.forEach((value) {
      cookie +="${value.toString().split(";")[0]}; ";
    });
     return cookie;
  }

  static _setCookie(Map<String,dynamic> headers) async{
    headers["Cookie"] = await _getCookie2();
  }

  static Dio _getDio() {
    return _HttpHolder.dio;
  }

  static String _getFullUrl(String api) {
    if (api.startsWith("http") || api.startsWith("https")) {
      return api;
    }
    return AppUrl.getUrl(api);
  }

  static Future<dynamic> get(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    if (headers == null) {
      headers = Map<String,dynamic>();
    }
//    var cookieList = await _getCookie();
    _setCookie(headers);
    Response resp = await _getDio().get(_getFullUrl(api),
        queryParameters: params,
        options: Options(headers: headers, /*cookies: cookieList*/));
    if (resp.statusCode / 100 == 2) {
      var data = resp.data;
      if (data is String) {
        return json.decode(data);
      }
      return data;
    }
    throw _errorException(resp.statusCode);
  }

  static Future<dynamic> post(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    if (headers == null) {
      headers = Map<String,dynamic>();
    }
    _setCookie(headers);
    Response resp = await _getDio().post(_getFullUrl(api),
        queryParameters: params,
        options: Options(headers: headers, /*cookies: cookieList*/));
    print("net_data = ${resp.data}");
    if (api.contains(AppApi.LOGIN)) {
      resp.headers.forEach((key, values) {
        if (key == 'set-cookie') {
          var cookies = CookieManager.normalizeCookies(values);
          String cookieStr = json.encode(cookies);
          SpUtils.saveString("Cookie", cookieStr);
        }
      });
    }

    if (resp.statusCode / 100 == 2) {
      var data = resp.data;
      if (data is String) {
        return json.decode(data);
      }
      return data;
    }
    throw _errorException(resp.statusCode);
  }

  static Future<DataResult> getDataResult(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    var data = await get(api, params: params, headers: headers);
    var resultData = DataResult.fromJson(data);
    if (resultData.errorCode != 0) {
      throw _errorExceptionWithMsg(resultData.errorCode, resultData.errorMsg);
    }
    return resultData;
  }

  static Future<DataResult> postDataResult(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    var data = await post(api, params: params, headers: headers);

    var resultData = DataResult.fromJson(data);
    if (resultData.errorCode != 0) {
      throw _errorExceptionWithMsg(resultData.errorCode, resultData.errorMsg);
    }
    return resultData;
  }
}
