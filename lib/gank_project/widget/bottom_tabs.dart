import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/localization/gank_localizations.dart';
import 'package:flutter_app/gank_project/widget/icon_font.dart';

class BottomTabs extends StatefulWidget {
  final PageController pageController;
  final ValueChanged<int> onTap;

  BottomTabs(this.pageController, this.onTap);

  @override
  State<StatefulWidget> createState() {
    return _BottomTabsState();
  }
}

class _BottomTabsState extends State<BottomTabs> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var _bottomTabs = <BottomNavigationBarItem>[
      ///最新
      BottomNavigationBarItem(
        icon: Icon(IconFont(0xe67f)),
        title: Text(GankLocalizations.of(context).currentLocalized.gankNew),
      ),

      ///分类
      BottomNavigationBarItem(
          icon: Icon(IconFont(0xe603)),
          title: Text(
              GankLocalizations.of(context).currentLocalized.gankCategory)),

      /// 妹子
      BottomNavigationBarItem(
          icon: Icon(IconFont(0xe637)),
          title: Text(GankLocalizations.of(context).currentLocalized.girl)),

      /// 收藏
      BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          title: Text(
              GankLocalizations.of(context).currentLocalized.gankFavorite)),
    ];

    return BottomNavigationBar(
      items: _bottomTabs,
      type: BottomNavigationBarType.fixed,
      iconSize: 32,
      currentIndex: currentIndex,
      onTap: (index) {
        if (widget.onTap != null) {
          currentIndex = index;
          widget.pageController.jumpToPage(index);
          widget.onTap(index);
        }
      },
    );
  }
}
