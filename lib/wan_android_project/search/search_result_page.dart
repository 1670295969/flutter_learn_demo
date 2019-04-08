

import 'package:flutter/material.dart';
import 'package:flutter_app/wan_android_project/bean/article.dart';
import 'package:flutter_app/wan_android_project/bean/base_result.dart';
import 'package:flutter_app/wan_android_project/net/net_storage.dart';
import 'package:flutter_app/wan_android_project/page/article_item_view.dart';

class SearchResultPage extends StatefulWidget{


  static void push(BuildContext context,String key){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx){
      return SearchResultPage(ValueKey<String>(key));
    }));
  }



  String searchKey;

  SearchResultPage(ValueKey<String> key):super(key:key){
    searchKey = key.value;
  }




  @override
  State<StatefulWidget> createState() {
    return _SearchResultPageState();
  }

}


class _SearchResultPageState extends State<SearchResultPage>{

  List<ArticleItem> allDataList = List();

  var _currentPage = 0;

  _search(){
    String key = widget.searchKey;
    NetStorage.search(key,_currentPage)
    .then((data){
      var commonData = CommonData.fromJson(data.data);
      var searchList = ArticleItem.fromJsonArray(commonData.datas);

      _currentPage++;

      setState(() {
        if(_currentPage<=1){
          allDataList.clear();
        }
        allDataList.addAll(searchList);
      });
    });



  }

  @override
  void initState() {
    super.initState();
    _search();
  }





  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (ctx,index){
      return ArticleItemView(allDataList[index]);
    },
    itemCount: allDataList.length,);
  }

}