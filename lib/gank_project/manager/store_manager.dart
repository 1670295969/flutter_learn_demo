
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class StoreManager{

  static Store<AppState> get(BuildContext context){
    return StoreProvider.of<AppState>(context);
  }


}