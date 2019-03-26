

import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/article.dart';
import 'package:flutter_app/pra_project/net/net_storage.dart';
import 'package:flutter_app/pra_project/page/article_item_view.dart';

class ArticleListPage extends StatefulWidget{

  int id;
  ArticleListPage(this.id);


  @override
  State<StatefulWidget> createState() {
    return _ArticleListPageState();
  }

}

class _ArticleListPageState extends State<ArticleListPage>{

  int currentPage = 0;

  List<ArticleItem> articleList = List();
  ScrollController _controller =  ScrollController();



  _getArticleList() async{
    var data =  await NetStorage.getArticleListWithTagId(currentPage, widget.id);
    if(data == null) {
      return;
    }

    var pageList = ArticleItem.fromJsonArray(data.datas);
    currentPage++;
    setState(() {
      if(currentPage<=1){
        articleList.clear();
      }
      articleList.addAll(pageList);
    });
  }

  Future<Null> _pullToRefresh() async {
    currentPage = 0;
    _getArticleList();
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getArticleList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    if (articleList == null || articleList.isEmpty) {
      return  Center(
        child:  CircularProgressIndicator(),
      );
    } else {
      Widget listView =  ListView.builder(
        key:  PageStorageKey(widget.id),
        itemCount: articleList.length,
        itemBuilder: (context, i) => ArticleItemView(articleList[i]),
        controller: _controller,
      );

      return  RefreshIndicator(child: listView, onRefresh: _pullToRefresh);
    }
  }

}