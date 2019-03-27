import 'package:flutter/material.dart';
import 'package:flutter_app/plugin/toast_plugin_demo.dart';
import 'package:flutter_app/pra_project/bean/article.dart';
import 'package:flutter_app/pra_project/login/login_mamager.dart';
import 'package:flutter_app/pra_project/login/login_page.dart';
import 'package:flutter_app/pra_project/net/net_exceptions.dart';
import 'package:flutter_app/pra_project/net/net_storage.dart';
import 'package:flutter_app/pra_project/page/article_web_page.dart';

class ArticleItemView extends StatefulWidget {
  ArticleItem item;

  ArticleItemView(this.item);

  @override
  State<StatefulWidget> createState() {
    return _ArticleItemViewState(item);
  }
}

class _ArticleItemViewState extends State<ArticleItemView> {
  ArticleItem item;

  _ArticleItemViewState(this.item);

  Widget _authorInfo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Text("作者:    "),
              Text(
                "${item.author}",
                style: TextStyle(color: Colors.blue),
              )
            ],
          ),
        ),
        Text(
          item.niceDate,
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }

  Widget _titleInfo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text.rich(
            TextSpan(text: item.title),
            softWrap: true,
            style: TextStyle(fontSize: 16.0, color: Colors.black),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
  }

  Widget _bottomView() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "${item.chapterName}",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        InkWell(
          child: IconButton(
            icon: Icon(item.collect ? Icons.favorite : Icons.favorite_border),
            color: item.collect ? Colors.red : null,
          ),
          onTap: () {
            LoginManager.isLogin().then((value) {
              if (value == true) {
                _itemCollect(item);
              } else {
                LoginPage.toLogin(context);
              }
            });
          },
        )
      ],
    );
  }

  Widget _itemView() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 3),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: _authorInfo(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0),
            child: _titleInfo(),
          ),
          _bottomView(),
        ],
      ),
    );
  }

  //收藏或取消收藏
  _itemCollect(ArticleItem item) {
    //取消收藏
    if (item.collect) {
      NetStorage.unCollect(item.id).then((_) {
        setState(() {
          item.collect = false;
        });
      },onError: _handleError);
    } else {
      //收藏
      NetStorage.toCollect(item.id).then((_) {
        setState(() {
          item.collect = true;
        });
      }).catchError(_handleError);
    }
  }

  _handleError(dynamic e){
    debugPrint("$e");
    if(e is NetException){
      FlutterToast.toast(e.netErrorData);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: InkWell(
        child: _itemView(),
        onTap: () {
          ArticleWebPage.push(context, item.title, item.link);
        },
      ),
    );
  }
}
