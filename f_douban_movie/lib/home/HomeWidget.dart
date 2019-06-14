import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  Widget _searchBar() {
    return Row(
      children: <Widget>[
        Text(
          "深圳",
          style: TextStyle(fontSize: 16),
        ),
        Icon(Icons.arrow_drop_down),
        Expanded(
          flex: 1,
          child: TextField(
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: "电影 / 电视剧 / 影人",
              hintStyle: TextStyle(
                fontSize: 16,
              ),
              contentPadding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              filled: true,
              fillColor: Colors.black12,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 80,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(left: 20, right: 20),
          child: _searchBar(),
        ),
        Expanded(
          flex: 1,
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(height: 50),
                  child: TabBar(
                      unselectedLabelColor: Colors.black12,
                      labelColor: Colors.black87,
                      indicatorColor: Colors.black87,
                      tabs: [Tab(text: "正在热映"), Tab(text: "即将上映")]),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        Center(
                          child: Text("正在上映"),
                        ),
                        Center(
                          child: Text("即将上映"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
