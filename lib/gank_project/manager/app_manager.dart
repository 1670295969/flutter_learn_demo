import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/bean/github_user.dart';
import 'package:flutter_app/gank_project/config/gank_config.dart';
import 'package:flutter_app/gank_project/manager/user_manager.dart';
import 'package:flutter_app/gank_project/redux/app_state.dart';
import 'package:flutter_app/gank_project/redux/redux_locale.dart';
import 'package:flutter_app/gank_project/redux/redux_theme.dart';
import 'package:flutter_app/gank_project/redux/redux_user.dart';
import 'package:flutter_app/gank_project/utils/common_utils.dart';
import 'package:flutter_app/gank_project/utils/g_sp_utils.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class AppManager {
  static EventBus eventBus = EventBus();

  static Future<bool> initApp(BuildContext context) async {
    try {
      Store<AppState> store = StoreProvider.of(context);

      User localUser = await UserManager.getUserFromLocalStorage();
      if (localUser != null) {
        store.dispatch(UpDateUserAction(localUser));
      }

      //读取保存的主题
      String themeIndex = await GSPUtils.get(GankConfig.THEME_COLOR);
      if (themeIndex != null && themeIndex.isNotEmpty) {
        await AppManager.switchThemeData(context, int.parse(themeIndex));
      }

      //切换语言
      String localeIndex = await GSPUtils.get(GankConfig.LOCALE);
      if (localeIndex != null && localeIndex.length != 0) {
        await AppManager.changeLocale(context, int.parse(localeIndex));
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static switchThemeData(context, int index) async {
    Store store = StoreProvider.of(context);
    ThemeData themeData;
    List<Color> colors = CommonUtils.getThemeListColor();
    themeData = ThemeData(
      primaryColor: colors[index],
    );
    await GSPUtils.save(GankConfig.THEME_COLOR, index.toString());
    store.dispatch(RefreshThemeData(themeData));
  }

  static void changeLocale(BuildContext context, int index) async {
    Store<AppState> store = StoreProvider.of(context);
    Locale locale = store.state.platformLocale;
    switch (index) {
      case 0:
        locale = Locale("zh", "CH");
        break;
      case 1:
        locale = Locale("en", "US");
        break;
    }

    store.dispatch(RefreshLocalAction(locale));
    await GSPUtils.save(GankConfig.LOCALE, index.toString());
  }
}
