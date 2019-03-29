

import 'dart:convert';

import 'package:flutter_app/gank_project/bean/github_user.dart';
import 'package:flutter_app/gank_project/config/gank_config.dart';
import 'package:flutter_app/gank_project/utils/g_sp_utils.dart';

class UserManager{

  static Future<User> getUserFromLocalStorage() async{
    var userInfoJson = await GSPUtils.get(GankConfig.USER_INFO);
    if(userInfoJson!=null){
      var userMap = json.decode(userInfoJson);
      User user = User.fromJson(userMap);
      return user;
    }
    return null;
  }



}