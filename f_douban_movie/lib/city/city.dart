import 'package:flutter/material.dart';

class CityWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityWidgetState();
  }
}

class CityWidgetState extends State<CityWidget> {
  String currentCity;

  _initData() {
    currentCity = ModalRoute.of(context).settings.arguments;
    List<String> hotCitys = [
      '北京',
      '上海',
      '广州',
      '深圳',
      '成都',
      '武汉',
      '杭州',
      '重庆',
      '郑州',
      '南京',
      '西安',
      '苏州',
      '长沙',
      '天津',
      '福州'
    ];
  }

  Widget _initTab() {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            constraints: BoxConstraints.expand(height: 50),
            child: TabBar(
              unselectedLabelColor: Colors.black12,
              labelColor: Colors.black87,
              indicatorColor: Colors.green,
              tabs: <Widget>[Tab(text: "国内"), Tab(text: "国外")],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(
                physics: ClampingScrollPhysics(),
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _initData();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          "选择城市",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: _initTab(),
    );
  }
}
