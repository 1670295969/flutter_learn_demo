import 'package:flutter/material.dart';

class CityWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CityWidgetState();
  }
}

class CityWidgetState extends State<CityWidget> {
  String currentCity;
  List<String> hotCitys;

  _initData() {
    currentCity = ModalRoute.of(context).settings.arguments;
    hotCitys = [
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
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: TextField(
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "请输入城市名查询",
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.black38,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 20),
                        child: MaterialButton(
                          onPressed: () {},
                          child: Container(
                            width: 50,
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                Text(currentCity),
                              ],
                            ),
                          ),
                          color: Colors.white,
                          elevation: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 20),
                        child: Text(
                          "热门城市",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.6,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 40,
                            ),
                            itemCount: hotCitys.length,
                            itemBuilder: (context, index) {
                              return MaterialButton(
                                child: Text(hotCitys[index]),
                                color: Colors.white,
                                elevation: 0,
                                onPressed: () {
                                  Navigator.pop(context,hotCitys[index]);
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text("国外"),),
                ],
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
