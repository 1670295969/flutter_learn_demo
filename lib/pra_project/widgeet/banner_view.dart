import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/bean/banner.dart';

//banner 指示器

///指示器
class IndicatorWidget extends StatelessWidget {
  final Widget indicatorNormal;
  final Widget indicatorSelected;
  final double indicatorMargin;
  final int size;
  final int currentIndex;

  IndicatorWidget({
    Key key,
    this.size,
    this.currentIndex,
    this.indicatorNormal,
    this.indicatorSelected,
    this.indicatorMargin = 5.0,
  })  : assert(indicatorMargin != null),
        assert(size != null && size > 0),
        assert(currentIndex != null && currentIndex >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return this._renderIndicator(context);
  }

  //indicator container
  Widget _renderIndicator(BuildContext context) {
    Widget smallContainer = new Container(
      child: new Row(
        mainAxisSize: MainAxisSize.min,
        children: _renderIndicatorTag(),
      ),
    );

    //default implement
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Opacity(
        opacity: 0.5,
        child: new Container(
          height: 25,
          padding: new EdgeInsets.symmetric(horizontal: 16.0),
          color: Colors.black45,
          alignment: Alignment.centerRight,
          child: smallContainer,
        ),
      ),
    );
  }

  //generate every indicator item
  List<Widget> _renderIndicatorTag() {
    List<Widget> indicators = [];
    final int len = this.size;
    Widget selected =
        this.indicatorSelected ?? generateIndicatorItem(normal: false);
    Widget normal = this.indicatorNormal ?? generateIndicatorItem(normal: true);

    for (var index = 0; index < len; index++) {
      indicators.add(index == this.currentIndex ? selected : normal);
      if (index != len - 1) {
        indicators.add(new SizedBox(
          width: this.indicatorMargin,
        ));
      }
    }

    return indicators;
  }

  Widget generateIndicatorItem(
      {bool normal = true, double indicatorSize = 8.0}) {
    return new Container(
      width: indicatorSize,
      height: indicatorSize,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        color: normal ? Colors.white : Colors.red,
      ),
    );
  }
}

class BannerView extends StatefulWidget {
  final int delayTime; //间隔时间秒
  final int scrollTime; //滑动耗时毫秒
  final double height; //banner高度
  final List<ArticleBanner> data; //banner内容
  int _index = 0; //当前位置

  BannerView({Key key, @required this.data, this.delayTime = 3, this.scrollTime = 200, this.height = 200.0}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new BannerViewState();
  }
}

class BannerViewState extends State<BannerView> {
  PageController controller = new PageController();
  Timer timer;
  List<Widget> bannerContentView;

  @override
  void initState() {
    super.initState();
    _initBannerContentView();
    resetTimer();
  }

  _initBannerContentView(){
    List<ArticleBanner> data = widget.data;

    List<Widget> items = [];
    if (data != null && data.length > 0) {
      for (var i = 0; i < data.length; i++) {
        var item = data[i];
        var imgUrl = item.imagePath;
        var title = item.title;
        items.add( AspectRatio(
              aspectRatio: 3.0 / 1.0,
              child: new Stack(
                children: <Widget>[
                  new Image.network(
                    imgUrl,
                    fit: BoxFit.cover,
                    width: 1000.0,
                  ),
                  new Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: new Container(
                      width: 1000.0,
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5.0),
                      child: new Text(title,
                          style: new TextStyle(
                              color: Colors.white, fontSize: 15.0)),
                    ),
                  ),
                ],
              ),
            )
        );
      }
    }

    bannerContentView = items;

  }




  ///重置计时器
  void resetTimer() {
    clearTimer();
    timer = new Timer.periodic(new Duration(seconds: widget.delayTime), (Timer timer) {
      // ignore: invalid_use_of_protected_member
      if (controller.positions.isNotEmpty) {
        widget._index = controller.page.round() + 1;
        controller.animateToPage(widget._index, duration: new Duration(milliseconds: widget.scrollTime), curve: Curves.linear);
        setState(() {});
      }
    });
  }

  ///清除计时器
  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        _buildBanner(),
        _renderIndicator(),
      ],
    );
  }

  void _handOnItemClick(itemData) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      print("clicked banner");
//      return new ArticleDetailPage(title:itemData['title'],url: itemData['link']);
    }));
  }

  Widget _buildBanner() {
    return new SizedBox(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: new GestureDetector(
        onTap: (){
          _handOnItemClick(widget.data[widget._index]);
        },
        onTapDown: (details) {
          clearTimer();
        },
        onTapUp: (details) {
          resetTimer();
        },
        onTapCancel: () {
          resetTimer();
        },
        child: new PageView.builder(
          controller: controller,
          physics: const PageScrollPhysics(parent: const ClampingScrollPhysics()),
          itemBuilder: (BuildContext context, int index) {
            return bannerContentView[index % widget.data.length];
          },
          itemCount: 0x7fffffff,
          onPageChanged: (index) {
            setState(() {
              widget._index = index;
            });
          },
        ),
      ),
    );
  }

  /// indicator widget
  Widget _renderIndicator() {
    return new IndicatorWidget(
      size: widget.data.length,
      currentIndex: widget._index % widget.data.length,
    );
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }
}

