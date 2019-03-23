import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/article.dart';
import 'package:flutter_app/pra_project/bean/banner.dart';
import 'package:flutter_app/pra_project/bean/base_result.dart';
import 'package:flutter_app/pra_project/net/base_api.dart';
import 'package:flutter_app/pra_project/net/net_utils.dart';
import 'package:flutter_app/pra_project/page/article_item_view.dart';
import 'package:flutter_app/pra_project/utils/constants.dart';
import 'package:flutter_app/pra_project/widgeet/banner_view.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List articleDataList = List();

  var bannerData;

  //当前文章已经加载到了第几页
  var curArticlePage = 0;

  //所有文章
  var articleTotalSize = 0;
  ScrollController _controller;
  BannerView _bannerView;

  //获取banner列表
  void _getBannerList() {
    NetProxy.get(AppApi.BANNER, onSuccess: (data) {
      var dataResult = DataResult.fromJson(data);
      var bannerList = ArticleBanner.fromJsonArray(dataResult.data);
      setState(() {
        bannerData = bannerList;
        _bannerView = BannerView(
          data: bannerList,
        );
      });
    });
  }

  //获取文章列表
  void _getArticleList() {
    NetProxy.get(AppApi.ARTICLE_LIST + "$curArticlePage/json",
        onSuccess: (data) {
      var dataResult = DataResult.fromJson(data);
      var pageData = CommonData.fromJson(dataResult.data);
      articleTotalSize = pageData.total;
      curArticlePage++;
      var articleList = ArticleItem.fromJsonArray(pageData.datas);
      setState(() {
        if (curArticlePage <= 0) {
          articleDataList.clear();
        }
        articleDataList.addAll(articleList);
        if (articleDataList.length >= articleTotalSize) {
          articleDataList.add(Constants.END_LINE_TAG);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        var maxScroll = _controller.position.maxScrollExtent;
        var pixels = _controller.position.pixels;
        if (maxScroll == pixels && articleDataList.length < articleTotalSize) {
          //滑到了底部需要加载新的数据
          _getArticleList();
        }
      });

    _getBannerList();
    _getArticleList();
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (articleDataList == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      Widget listView = ListView.builder(
        itemCount: articleDataList.length + 1,
        itemBuilder: (context, i) => buildItem(i),
        controller: _controller,
      );
      return listView;
    }
  }

  Widget buildItem(int i) {
    if (i == 0) {
      //第一条是banner
      return Container(
        height: 180.0,
        child: _bannerView,
      );
    }

    i -= 1;

    var itemData = articleDataList[i];

    if (itemData is String && itemData == Constants.END_LINE_TAG) {
      return Center(
        child: Text("----------------end-----------------------"),
      );
    } else {
      var item = itemData as ArticleItem;
      return ArticleItemView(item);
    }
  }
}
