import 'package:dio/dio.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';

typedef OnSuccessCallBack(Map<String, dynamic> json);

typedef OnErrorCallBack(int errorCode, String errorMessage);

class _HttpHolder {
  static Dio dio = Dio();
}

class NetProxy {
  static Dio _getDio() {
    return _HttpHolder.dio;
  }

  static String _getFullUrl(String api) {
    if (api.startsWith("http") || api.startsWith("https")) {
      return api;
    }
    return AppUrl.getUrl(api);
  }


  static void get(String api, {
    Map<String, dynamic> params,
    Map<String, dynamic> headers,
    OnSuccessCallBack onSuccess,
    OnErrorCallBack onError
  }) {
    _getDio().get(_getFullUrl(api),
        queryParameters: params,
      options: Options(headers: headers)
    ).then((resp){

      if(resp.statusCode != 200){
        onError(resp.statusCode,"请求数据错误");
        return;
      }
      onSuccess(resp.data);
    });
  }
}
