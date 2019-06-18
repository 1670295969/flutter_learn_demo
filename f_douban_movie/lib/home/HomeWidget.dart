import 'package:f_douban_movie/home/hot_movie.dart';
import 'package:f_douban_movie/inherited/inherited.dart';
import 'package:f_douban_movie/route/route.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  String currentCity = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentCity = ShareDataInheritedWidget.of(context).currentCity;
  }

  Widget _searchBar() {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Text(
            currentCity,
            style: TextStyle(fontSize: 16),
          ),
          onTap: () async {
            var city = await RouteUtils.pushedToCity(context, currentCity);
            if (city != null) {
              setState(() {
                ShareDataInheritedWidget.of(context).currentCity = city;
              });
            }
          },
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
                        HotMoviesListWidget(),
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
