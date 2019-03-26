import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/find.dart';
import 'package:flutter_app/pra_project/find/article_list_page.dart';

class ArticleManagerPage extends StatefulWidget {
  static push(BuildContext context, FindItem item) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ArticleManagerPage(item);
    }));
  }

  FindItem findItem;

  ArticleManagerPage(this.findItem);

  @override
  State<StatefulWidget> createState() {
    return _ArticleManagerPageState();
  }
}

class _ArticleManagerPageState extends State<ArticleManagerPage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<Tab> tabList = List();
  List<FindItem> childrenList;

  @override
  void initState() {
    super.initState();

    childrenList = widget.findItem.children;

    childrenList?.forEach((value) {
      tabList.add(Tab(
        text: value.name,
      ));
    });

    _controller = TabController(
        length: tabList == null ? 0 : tabList.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.findItem.name),
      ),
      body: DefaultTabController(
          length: childrenList.length,
          child: Scaffold(
            appBar: TabBar(
              tabs: tabList,
              isScrollable: true,
              controller: _controller,
              labelColor: Colors.blue,
              indicatorColor: Colors.blue,
              unselectedLabelColor: Colors.black,
            ),
            body: TabBarView(
                controller: _controller,
                children: childrenList.map((value) {
                  return ArticleListPage(value.id);
                }).toList()),
          )),
    );
  }
}
