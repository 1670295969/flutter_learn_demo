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
          filled:true,
          fillColor: Colors.black12
        ),

      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _searchWidget(),
      ],
    );
  }
}
