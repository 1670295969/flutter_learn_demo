


import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/constant/colors.dart';
import 'package:flutter_app/gank_project/localization/gank_localizations_delegate.dart';
import 'package:flutter_app/gank_project/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main(){

  runApp(GankMainApp());


}

class GankMainApp extends StatelessWidget{

  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
      userInfo: null,
      themeData: ThemeData(
          primaryColor:AppColors.PRIMARY_DEFAULT_COLOR,
          platform: TargetPlatform.android
      ),
      locale: Locale("zh",'CH'),
    ),
  );


  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreBuilder<AppState>(builder: (context,store){
        return MaterialApp(
          theme: store.state.themeData,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GankLocalizationsDelegate.delegate,
          ],
          locale: store.state.locale,
          supportedLocales: [store.state.locale],
          routes: {

          },
        );
      }),
    );
  }

}





