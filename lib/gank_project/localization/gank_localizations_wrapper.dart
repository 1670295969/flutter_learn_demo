import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/redux/app_state.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GankLocalizationsWrapper extends StatefulWidget {
  final Widget child;

  GankLocalizationsWrapper({Key key, this.child}) : super(key: key);

  @override
  _GankLocalizationsWrapperState createState() => _GankLocalizationsWrapperState();
}

class _GankLocalizationsWrapperState extends State<GankLocalizationsWrapper> {
  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(builder: (context, store) {
      ///通过 StoreBuilder 和 Localizations 实现实时多语言切换
      return Localizations.override(
        context: context,
        locale: store.state.locale,
        child: widget.child,
      );
    });
  }
}
