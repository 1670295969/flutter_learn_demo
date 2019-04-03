import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/gank_project/api/gank_net_storage.dart';
import 'package:flutter_app/gank_project/event/event_change_column.dart';
import 'package:flutter_app/gank_project/event/event_refresh_new.dart';
import 'package:flutter_app/gank_project/event/event_show_history_date.dart';
import 'package:flutter_app/gank_project/manager/app_manager.dart';
import 'package:flutter_app/gank_project/manager/favorite_manager.dart';
import 'package:flutter_app/gank_project/page/category_page.dart';
import 'package:flutter_app/gank_project/page/favorite_page.dart';
import 'package:flutter_app/gank_project/page/new_page.dart';
import 'package:flutter_app/gank_project/page/welfare_page.dart';
import 'package:flutter_app/gank_project/utils/navigator_utils.dart';
import 'package:flutter_app/gank_project/widget/bottom_tabs.dart';
import 'package:flutter_app/gank_project/widget/gank_drwaer.dart';
import 'package:flutter_app/gank_project/widget/history_date.dart';

class GkHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GkHomePageState();
  }
}

class _GkHomePageState extends State<GkHomePage> {
  int _currentPageIndex = 0;
  String _currentDate;
  List _historyData;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _getHistoryData();
    _registerEventListener();
  }

  ///获取
  _getHistoryData() async {
    var historyData = await GankNetStorage.getHistoryDateData();

    setState(() {
      _historyData = historyData;
      _currentDate = "今日最新干货";
    });
  }

  _registerEventListener() {
    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event) {
      if (mounted) {
        _currentDate = event.date;
      }
    });
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: _pageChange,
          controller: _pageController,
          children: <Widget>[
            NewPage(),
            CategoryPage(),
            WelfarePage(),
            FavoritePage(),
          ],
        ),
        HistoryDate(_historyData),
      ],
    );
  }

  _pageChange(int index) {
    if (index != 0) {
      AppManager.eventBus.fire(ShowHistoryDateEvent.hide());
    }
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
      }
    });
  }

  _buildAppBar() {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Offstage(
        offstage: _currentPageIndex != 0,
        child: Text(_currentDate ?? ""),
      ),
      actions: <Widget>[_buildActions()],
    );
  }

  _buildActions() {
    return IconButton(
      icon: Icon(
        getActionIcon(),
        size: 22,
        color: Colors.white,
      ),
      onPressed: () async {
        if (_currentPageIndex == 0) {
          ///显示隐藏日期
          AppManager.notifyShowHistoryDateEvent();
        } else if (_currentPageIndex == 1) {
          NavigatorUtils.goSearch(context);
        } else if (_currentPageIndex == 2) {
          AppManager.eventBus.fire(ChangeWelfareColumnEvent());
        } else {
          FavoriteManager.syncFavorites(context);
        }
      },
    );
  }

  IconData getActionIcon() {
    if (_currentPageIndex == 0) {
      return IconData(0xe8a6, fontFamily: 'IconFont');
    } else if (_currentPageIndex == 1) {
      return IconData(0xe783, fontFamily: 'IconFont');
    } else if (_currentPageIndex == 2) {
      return IconData(0xe63a, fontFamily: 'IconFont');
    } else {
      return IconData(0xe619, fontFamily: 'IconFont');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GankDrawer(),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: BottomTabs(_pageController, _pageChange),
    );
  }
}
