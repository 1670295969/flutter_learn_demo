import 'package:f_douban_movie/bean/hot_movie_data.dart';
import 'package:flutter/material.dart';

class HotMovieItemWidget extends StatefulWidget {
  HotMovieData hotMovieData;

  HotMovieItemWidget(this.hotMovieData);

  @override
  State<StatefulWidget> createState() {
    return HotMovieItemWidgetState();
  }
}

class HotMovieItemWidgetState extends State<HotMovieItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(
            widget.hotMovieData.images.medium,
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.hotMovieData.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    widget.hotMovieData.rating.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  Text('导演: ' + widget.hotMovieData.directors[0].name,
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                  Text('主演: ' + widget.hotMovieData.casts[0].name,
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.hotMovieData.collectCount.toString() + "人看过",
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
                OutlineButton(
                  child: Text(
                    "购票",
                    style: TextStyle(fontSize: 16),
                  ),
                  color: Colors.red,
                  textColor: Colors.red,
                  highlightedBorderColor: Colors.red,
                  borderSide: BorderSide(color: Colors.red),
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}