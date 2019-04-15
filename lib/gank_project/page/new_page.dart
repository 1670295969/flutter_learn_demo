
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/api/gank_net_storage.dart';
import 'package:flutter_app/gank_project/bean/gank_item.dart';
import 'package:flutter_app/gank_project/bean/gank_post.dart';
import 'package:flutter_app/gank_project/event/event_refresh_new.dart';
import 'package:flutter_app/gank_project/manager/app_manager.dart';
import 'package:flutter_app/gank_project/widget/gank_item_title.dart';
import 'package:flutter_app/gank_project/widget/gank_list_item.dart';
import 'package:flutter_app/gank_project/widget/refresh_factory.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";


class NewPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NewPageState();
  }

}

// AutomaticKeepAliveClientMixin wantKeepAlive 保持页面切换不会被重置
class _NewPageState extends State<NewPage> with AutomaticKeepAliveClientMixin{

  String _girlImage;
  String _date;
  List<GankItem> _gankItems;
  RefreshController _refreshController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    AppManager.eventBus.on<RefreshNewPageEvent>().listen((event){
      if(mounted){
        _date = event.date;
        _getNewData(date: _date);
      }
    });

    _refreshController = RefreshController();
    _getNewData();

  }

  Future _onRefresh(bool up) async{
    if(up){
      await _getNewData(date: _date,isRefresh: true);
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
  }

  Future _getNewData({String date,bool isRefresh = false}) async{
    _date = date;

    if(!isRefresh){
      setState(() {
        _isLoading = true;
      });
    }

    var todayJson ;
    if(date == null){
      todayJson = await GankNetStorage.getTodayData();
    }else{
      todayJson = await GankNetStorage.getSpecialDayData(_date);
    }

    var todayItem = GankPost.fromJson(todayJson);

    setState(() {
      _gankItems = todayItem.gankItems;
      _girlImage = todayItem.girlImage;
      _isLoading = false;
    });

  }


  @override
  bool get wantKeepAlive => true;


  GestureDetector _buildImageBanner(BuildContext context){
    return GestureDetector(
      onTap: (){
//        Navigator.of(context).push(MaterialPageRoute(builder: (context){
////          return
//        }));
      },
      child: CachedNetworkImage(
        height: 200,
        imageUrl: _girlImage,
        fit: BoxFit.cover,
      ),
    );
  }


  ListView _buildListView(){
    return ListView.builder(
      itemCount: _gankItems == null ? 0 : _gankItems.length + 1,
      itemBuilder: (context,i){
        if(i == 0){
          return _buildImageBanner(context);
        }else{
          GankItem gankItem = _gankItems[i-1];
          return gankItem.isTitle ? GankItemTitle(gankItem.category) : GankListItem(gankItem);
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Offstage(
          offstage: _isLoading?true:false,
          child: SmartRefresher(
            enablePullDown: true,
              enablePullUp: false,
              onRefresh: _onRefresh,
              onOffsetChange: null,
              headerBuilder: RefreshFactory.buildDefaultHeader,
              controller: _refreshController,
              child: _buildListView()


          ),
        )
      ],
    );
  }

}