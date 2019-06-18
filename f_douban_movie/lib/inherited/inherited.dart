import 'package:flutter/material.dart';

class ShareDataInheritedWidget extends InheritedWidget {
  String currentCity;

  static ShareDataInheritedWidget of(BuildContext context){
    return context.inheritFromWidgetOfExactType(ShareDataInheritedWidget);
  }

  ShareDataInheritedWidget(this.currentCity, {child: Widget})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return (oldWidget as ShareDataInheritedWidget).currentCity != currentCity;
  }
}
