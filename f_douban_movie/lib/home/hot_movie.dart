import 'package:f_douban_movie/bean/hot_movie_data.dart';
import 'package:f_douban_movie/home/hot_movie_item.dart';
import 'package:f_douban_movie/inherited/inherited.dart';
import 'package:f_douban_movie/net/DouBanNetStorage.dart';
import 'package:flutter/material.dart';

class HotMoviesListWidget extends StatefulWidget {

  HotMoviesListWidget();


  @override
  State<StatefulWidget> createState() {
    return HotMovieListWidgetStatus();
  }
}

class HotMovieListWidgetStatus extends State<HotMoviesListWidget> with AutomaticKeepAliveClientMixin {
  List<HotMovieData> hotMovies = [];
  String currentCity;
  @override
  void initState()  {
    super.initState();

//    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentCity = ShareDataInheritedWidget.of(context).currentCity;
    DouBanNetStorage.reqHotMovieList(currentCity).then((value){
      hotMovies = value;
      setState(() {

      });
    });

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
  bool get wantKeepAlive => true;//返回 true，表示不会被回收
}
