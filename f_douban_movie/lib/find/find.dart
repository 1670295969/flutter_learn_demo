import 'package:flutter/material.dart';

class MoviesWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoviesWidgetState();
  }
}

class MoviesWidgetState extends State<MoviesWidget> {
  Widget _searchWidget() {
    return Container(
      height: 80,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
        decoration: InputDecoration(
            hintText: "电影 / 电视剧 / 影人",
            hintStyle: TextStyle(fontSize: 16),
            contentPadding: EdgeInsets.only(top: 8, bottom: 8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            filled: true,
            fillColor: Colors.black12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _searchWidget(),
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
                    tabs: [
                      Tab(
                        text: '电影',
                      ),
                      Tab(
                        text: '电视',
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        Center(
                          child: Text("电影"),
                        ),
                        Center(
                          child: Text("电视"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
