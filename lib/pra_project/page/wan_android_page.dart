//主界面
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/base_result.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';
import 'package:flutter_app/pra_project/net/net_utils.dart';
import 'package:flutter_app/pra_project/find/find_tab.dart';
import 'package:flutter_app/pra_project/page/home_tab.dart';
import 'package:flutter_app/pra_project/page/mine_tab.dart';
import 'package:flutter_app/pra_project/search/search_main.dart';

//import 'package:dio/dio.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_app/pra_project/bean/base_result.dart';
//import 'package:flutter_app/pra_project/net/base_api.dart';
//import 'package:flutter_app/pra_project/net/net_utils.dart';

class WanAndroidMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WanAndroidMainPageState();
  }
}

class _WanAndroidMainPageState extends State<WanAndroidMainPage>
    with TickerProviderStateMixin {
  int _curIndex = 0;

  List<BottomNavigationBarItem> _navViewList;

  var _bottomNavTitles = ['首页', '发现', '我的'];
  final navigatorKey = GlobalKey<NavigatorState>();

  var _body;

  BottomNavigationBarItem _getBottomNavItem(IconData navIcon, Text navTitle) {
    return BottomNavigationBarItem(icon: Icon(navIcon), title: navTitle);
  }

  _initData() {
    _body = IndexedStack(
      children: <Widget>[HomePage(), FindPage(), MinePage()],
      index: _curIndex,
    );
  }

  _initBottomNavList() {
    _navViewList = [
      _getBottomNavItem(Icons.home, Text(_bottomNavTitles[0])),
      _getBottomNavItem(Icons.find_in_page, Text(_bottomNavTitles[1])),
      _getBottomNavItem(Icons.person, Text(_bottomNavTitles[2])),
    ];
  }

  @override
  void initState() {
    super.initState();
    _initBottomNavList();
  }

  _toSearch() {
//    SearchMain.push(context);
    navigatorKey.currentState
        .push(MaterialPageRoute(builder: (ctx) => SearchMain(null)));
  }

  Scaffold _home() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _bottomNavTitles[_curIndex],
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _toSearch,
          )
        ],
      ),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: _navViewList,
        currentIndex: _curIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (selectedIndex) async {
          setState(() {
            _curIndex = selectedIndex;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initData();
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
      home: _home(),
    );
  }
}
