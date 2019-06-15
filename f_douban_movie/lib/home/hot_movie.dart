import 'package:f_douban_movie/bean/hot_movie_data.dart';
import 'package:f_douban_movie/home/hot_movie_item.dart';
import 'package:f_douban_movie/net/DouBanNetStorage.dart';
import 'package:flutter/material.dart';

class HotMoviesListWidget extends StatefulWidget {


  String currentCity;

  HotMoviesListWidget(this.currentCity);


  @override
  State<StatefulWidget> createState() {
    return HotMovieListWidgetStatus();
  }
}

class HotMovieListWidgetStatus extends State<HotMoviesListWidget> with AutomaticKeepAliveClientMixin {
  List<HotMovieData> hotMovies = [];

  @override
  void initState()  {
    super.initState();

    DouBanNetStorage.reqHotMovieList(widget.currentCity).then((value){
      hotMovies = value;
      setState(() {

      });
    });
//    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(hotMovies == null || hotMovies.isEmpty){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return HotMovieItemWidget(hotMovies[index]);
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 1,
            color: Colors.black26,
          );
        },
        itemCount: hotMovies.length,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;//返回 true，表示不会被回收
}
