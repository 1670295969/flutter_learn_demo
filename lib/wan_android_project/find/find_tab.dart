import 'package:flutter/material.dart';
import 'package:flutter_app/wan_android_project/bean/find.dart';
import 'package:flutter_app/wan_android_project/find/article_manager_page.dart';
import 'package:flutter_app/wan_android_project/net/net_storage.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FindPageState();
  }
}

class FindPageState extends State<FindPage> {
  List<FindItem> findList;

  _getFindList() async {
    NetStorage.getFindList().then((data) {
      var dataList = FindItem.fromJsonArray(data.data);
      setState(() {
        findList = dataList;
      });
    }, onError: (e) {
      setState(() {});
    });
  }

  Widget _buildItem(FindItem item) {
    var title = item.name;
    var subTitle = "";

    item.children?.forEach((value) {
      subTitle += "${value.name},  ";
    });

    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                child: Text(
                  title,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Text(
                  subTitle,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
          Center(
            child: Container(
              margin: EdgeInsets.all(6),
              child: Icon(
                Icons.chevron_right,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getFindList();
  }

  Future<Null> _pullToRefresh() async {
    _getFindList();
    return null;
  }

  Widget _buildChildren() {
    if (findList == null || findList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) => InkWell(
              child: _buildItem(findList[index]),
              onTap: () {
                ArticleManagerPage.push(context, findList[index]);
              },
            ),
        itemCount: findList.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(child: _buildChildren(), onRefresh: _pullToRefresh);
  }
}
