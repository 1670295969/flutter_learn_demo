

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/gank_project/net/http_code.dart';
import 'package:flutter_app/gank_project/net/http_response.dart';
class HttpManager{


  static Dio _dio = Dio();


  static NetResponse _handleResult(Response response) {

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetResponse(response.data, true, HttpCodeHandler.SUCCESS,
            headers: response.headers);
      }else{
        return NetResponse(response.data, false, response.statusCode,
            headers: response.headers);
      }
    } catch (e) {
      return NetResponse(response.data, false, response.statusCode,
          headers: response.headers);
    }


  }

  static Future<NetResponse> get(url,{
    Map<String,dynamic> params,
    Map<String,dynamic> headers,
  }) async{
     Response response = await _dio.get(url,queryParameters: params,options: Options(headers: headers));
   return _handleResult(response);

  }

  static Future<NetResponse> post(url,{
    Map<String,dynamic> params,
    Map<String,dynamic> headers,
  }) async{
    Response response = await _dio.post(url,data: params,options: Options(headers: headers));
    return _handleResult(response);
  }


  static Future<NetResponse> put(url,{
    Map<String,dynamic> params,
    Map<String,dynamic> headers,
  }) async{
    Response response = await _dio.put(url,data: params,options: Options(headers: headers));
    return _handleResult(response);

  }


  static Future<NetResponse> patch(url,{
    Map<String,dynamic> params,
    Map<String,dynamic> headers,
  }) async{
    Response response = await _dio.patch(url,data: params,options: Options(headers: headers));
    return _handleResult(response);

  }

}

