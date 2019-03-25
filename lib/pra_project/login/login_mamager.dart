import 'package:flutter_app/pra_project/utils/sp_utils.dart';
import 'dart:async';

class LoginManager {

  static const String KEY_IS_LOGIN = "is_login";
  static const String KEY_USER_NAME = "user_name";

  static Future<bool> saveUserInfo(String userName) async {
     SpUtils.saveString(KEY_USER_NAME,userName);
     return SpUtils.saveBool(KEY_IS_LOGIN, true);
  }

  static Future<bool> clearLoginInfo() async{
    SpUtils.saveString(KEY_USER_NAME, "");
    return SpUtils.saveBool(KEY_IS_LOGIN, false);
  }




  static Future<bool> isLogin() async {
    return SpUtils.getBool(KEY_IS_LOGIN);
  }
}
