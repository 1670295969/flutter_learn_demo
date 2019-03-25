import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/article.dart';
import 'package:flutter_app/pra_project/login/login_mamager.dart';
import 'package:flutter_app/pra_project/login/login_page.dart';
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

  Widget _AuthorInfo() {
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
          onTap: () async {
//            var isLogin = await LoginManager.isLogin();
            LoginPage.toLogin(context);
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
            child: _AuthorInfo(),
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
