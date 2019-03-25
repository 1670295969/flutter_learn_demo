import 'package:dio/dio.dart';
import 'package:flutter_app/pra_project/bean/base_result.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';
import 'package:flutter_app/pra_project/net/net_exceptions.dart';

typedef OnSuccessCallBack(dynamic json);

typedef OnErrorCallBack(int errorCode, String errorMessage);

class _HttpHolder {
  static Dio dio = Dio();
}

class NetProxy {
  static NetException _errorException(int netCode) {
    return NetException(netCode, "请求数据错误");
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
    Response resp = await _getDio().get(_getFullUrl(api),
        queryParameters: params, options: Options(headers: headers));
    if (resp.statusCode / 100 == 2) {
      return resp.data;
    }
    throw _errorException(resp.statusCode);
  }

  static Future<dynamic> post(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    Response resp = await _getDio().post(_getFullUrl(api),
        queryParameters: params, options: Options(headers: headers));
    if (resp.statusCode / 100 == 2) {
      return resp.data;
    }
    throw _errorException(resp.statusCode);
  }

  static Future<DataResult> getDataResult(String api,
      {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
    var data = await get(api, params: params, headers: headers);
    return DataResult.fromJson(data);
  }
}
