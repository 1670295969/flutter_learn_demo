

import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/page/history_page.dart';
import 'package:flutter_app/gank_project/page/search_page.dart';
import 'package:flutter_app/gank_project/redux/app_state.dart';
import 'package:flutter_app/gank_project/utils/common_utils.dart';
import 'package:flutter_app/gank_project/widget/icon_font.dart';
import 'package:flutter_app/gank_project/widget/sizable_drawer.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';


class GankDrawer extends StatefulWidget {




  @override
  State<StatefulWidget> createState() {
    return _GankDrawerState();
  }

}

class _GankDrawerState extends State<GankDrawer> with SingleTickerProviderStateMixin{

  Animation<Offset> _drawerDetailsPosition;
  bool _showDrawerContents = true;
  AnimationController _controllerDrawer;
  Animation<double> _drawerContentsOpacity;
  Animatable<Offset> _drawerDetailsTween;


  @override
  void initState() {
    super.initState();
    _controllerDrawer = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    
    _drawerContentsOpacity = CurvedAnimation(
        parent: ReverseAnimation(_controllerDrawer),
        curve: Curves.fastOutSlowIn);

    _drawerDetailsTween = Tween<Offset>(
      begin: Offset(0.0, -1.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.fastOutSlowIn,));

    _drawerDetailsPosition = _controllerDrawer.drive(_drawerDetailsTween);
    
  }

  @override
  Widget build(BuildContext context) {
    return SizableDrawer(
      widthPercent: 0.75,
      child: Column(
        children: <Widget>[
          StoreBuilder<AppState>(
            builder: (context,store){
              return UserAccountsDrawerHeader(
                  accountName: Text(
                    store.state.userInfo?.userName ?? CommonUtils.getLocale(context).pleaseLogin
                  ),
                  accountEmail: Text(
                    store.state.userInfo?.userDesc ?? "什么也没有"
                  ),
                currentAccountPicture: GestureDetector(
                  onTap: (){
                    if(!(store.state.userInfo?.isLogin??false)){
                      Navigator.of(context).pushNamed("login");
                    }
                  },

                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,width: 1.0),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: store.state.userInfo?.avatarUrl == null
                          || store.state.userInfo.avatarUrl.isEmpty
                          ? Image.asset("images/gank.png") : CachedNetworkImage(imageUrl: store.state.userInfo.avatarUrl,),
                    ),
                  ),
                ),
                margin: EdgeInsets.zero,
                onDetailsPressed: store.state.userInfo?.isLogin??false?(){
                    _showDrawerContents = !_showDrawerContents;
                    if(_showDrawerContents){
                      _controllerDrawer.reverse();
                    }else{
                      _controllerDrawer.forward();
                    }
                }:null,
              );
            },
          ),

          MediaQuery.removePadding(
              context: context,
              removeTop:  true,
              child: Expanded(
                  child: ListView(
                    children: <Widget>[
                      FadeTransition(
                        opacity: _drawerContentsOpacity,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding:EdgeInsets.only(top:8.0),
                              child: ListTile(
                                leading: Icon(IconFont(0xe655),
                                color: Color(0xff737373),
                                ),
                                title: Text(
                                    CommonUtils.getLocale(context).searchGanHuo,
                                ),
                                onTap: (){
                                  _goToActivity(context, SearchPage());
                                },
                              ),
                            ),

                            ListTile(
                              leading: Icon(IconFont(0xe8a6),color:  Color(0xff737373),),
                              title: Text(CommonUtils.getLocale(context).historyGanHuo),
                              onTap: (){
                                _goToActivity(context, HistoryPage());
                              },
                            )


                          ],
                        ),
                      ),
                    ],
                  )
              ),
          ),


        ],
      ),
    );
  }

  void _goToActivity(BuildContext context,Widget activity){
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return activity;
    }));
  }

}