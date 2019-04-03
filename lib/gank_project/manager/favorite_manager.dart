

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/bean/gank_item.dart';
import 'package:flutter_app/gank_project/bean/github_user.dart';
import 'package:flutter_app/gank_project/constant/strings.dart';
import 'package:flutter_app/gank_project/event/event_refresh_db.dart';
import 'package:flutter_app/gank_project/localization/gank_localizations.dart';
import 'package:flutter_app/gank_project/manager/app_manager.dart';
import 'package:flutter_app/gank_project/manager/store_manager.dart';
import 'package:flutter_app/gank_project/utils/common_utils.dart';
import 'package:flutter_app/gank_project/widget/dialog_item.dart';
import 'package:flutter_app/gank_project/widget/icon_font.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:objectdb/objectdb.dart';


class FavoriteManager{

  static ObjectDB db;

  static init() async {
    Directory  directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path,"${AppStrings.STRING_DB_CACHE}");
    db = ObjectDB(path);
    await db.open();
  }

  static insert(GankItem item) async{
    await db.insert(item.toJsonMap());
  }

  static find(Map<String,dynamic> query) async{
    return db.find(query);
  }

  static remove(GankItem item) async{
    await db.remove({"itemId" : item.itemId});
  }

  static _clearFavorites() async{
    await db.remove({});
  }

  static clearFavorites(context) async {
    showDialog(
      context: context,
      builder: (ctx)=>
          AlertDialog(
            title: Text(CommonUtils.getLocale(ctx).tips),
            content: Text(CommonUtils.getLocale(ctx).confirmClearFavorites),
            actions: <Widget>[

              FlatButton(
                child: Text(CommonUtils.getLocale(ctx).cancel),
                onPressed: (){
                  Navigator.pop(ctx);
                },
              ),
              FlatButton(
                child: Text(CommonUtils.getLocale(ctx).confirm),
                onPressed: () async {
                  await _clearFavorites();
                  Fluttertoast.showToast(msg:  GankLocalizations.of(context)
                      .currentLocalized
                      .clearFavoritesSuccess);
                  AppManager.eventBus.fire(RefreshDBEvent());
                  Navigator.pop(ctx);

                },
              ),


            ],
          ),
    );
  }

  static closeDb() async {
    await db.close();
  }

  static syncFavorites(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
            title: Text(CommonUtils.getLocale(context).syncMethod),
            children: <Widget>[
              DialogItem(
                  icon: IconFont(0xe741),
                  color: AppManager.getThemeData(context).primaryColor,
                  text: CommonUtils.getLocale(context).syncMethodUpload,
                  onPressed: () async {
                    Navigator.pop(context);
                    CommonUtils.showToast(
                        await FavoriteManager.uploadFavoritesToServer(
                            context));
                  }),
              DialogItem(
                  icon: IconFont(0xe742),
                  color: AppManager.getThemeData(context).primaryColor,
                  text: CommonUtils.getLocale(context).syncMethodDownload,
                  onPressed: () async {
                    Navigator.pop(context);
                    CommonUtils.showToast(
                        await FavoriteManager.downloadFavoritesFromServer(
                            context));
                  }),
              DialogItem(
                  icon: IconFont(0xe662),
                  text: CommonUtils.getLocale(context).syncMethodMerge,
                  onPressed: () {
                    Navigator.pop(context);
                    CommonUtils.showToast(
                        CommonUtils.getLocale(context).supportLater);
                  },
                  color: AppManager.getThemeData(context).primaryColor),
            ]));
  }
  static uploadFavoritesToServer(BuildContext context) async {
    ///github
  }

  static downloadFavoritesFromServer(BuildContext context) async {
   ///github
  }











}

