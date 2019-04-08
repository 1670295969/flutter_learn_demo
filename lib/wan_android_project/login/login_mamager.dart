import 'package:flutter_app/wan_android_project/utils/sp_utils.dart';
import 'dart:async';

class LoginManager {
  static const String KEY_IS_LOGIN = "is_login";
  static const String KEY_USER_NAME = "user_name";

  static Future<bool> saveUserInfo(String userName) async {
    await SpUtils.saveString(KEY_USER_NAME, userName);
    return await SpUtils.saveBool(KEY_IS_LOGIN, true);
  }

  static Future<bool> clearLoginInfo() async {
    await SpUtils.saveString(KEY_USER_NAME, "");
    await SpUtils.saveString("Cookie", "");
    var value = await SpUtils.saveBool(KEY_IS_LOGIN, false);
    return value;
  }

  static Future<String> getUserName() async{
    return await SpUtils.getString(KEY_USER_NAME,"");
  }

  static Future<bool> isLogin() async {
    var isLogin =  await SpUtils.getBool(KEY_IS_LOGIN);
    return isLogin == true;
  }
}
