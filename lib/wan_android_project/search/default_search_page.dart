import 'package:flutter/material.dart';
import 'package:flutter_app/wan_android_project/bean/search.dart';
import 'package:flutter_app/wan_android_project/net/net_storage.dart';
import 'package:flutter_app/wan_android_project/page/article_web_page.dart';
import 'package:flutter_app/wan_android_project/search/search_main.dart';
import 'package:flutter_app/wan_android_project/search/search_result_page.dart';

class DefaultSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DefaultSearchPageState();
  }
}

class _DefaultSearchPageState extends State<DefaultSearchPage> {
  List<Widget> hotSearchList = List();

  List<Widget> blogList = List();

  Widget _buildItem(HotSearch item, Function onClicked) {
    return ActionChip(
      backgroundColor: Colors.blue,
      label: Text(
        item.name,
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () => onClicked(item),
    );
  }

  _getHotList() {
    NetStorage.hotSearchList().then((data) {
      List<HotSearch> dataList = HotSearch.fromJsonList(data.data);

      setState(() {
        dataList.forEach((item) {
          hotSearchList.add(_buildItem(item, (HotSearch value) {
            SearchMain.push(context, value.name);
          }));
        });
      });
    }, onError: (e) {});
  }

  _getFriendBlogList() {
    NetStorage.friendBlogList().then((data) {
      List<HotSearch> dataList = HotSearch.fromJsonList(data.data);
      setState(() {
        dataList.forEach((item) {
          blogList.add(_buildItem(item, (HotSearch value) {
            ArticleWebPage.push(context, value.name, value.link);
          }));
        });
      });
    }, onError: (e) {});
  }

  @override
  void initState() {
    super.initState();
    _getHotList();
    _getFriendBlogList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "大家都在搜",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: hotSearchList,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "热门博客",
            style: TextStyle(color: Colors.blue, fontSize: 18),
          ),
        ),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: blogList,
        ),
      ],
    );
  }
}
