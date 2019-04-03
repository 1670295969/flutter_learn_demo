

import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/manager/app_manager.dart';
import 'package:flutter_app/gank_project/utils/navigator_utils.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }

}


class _SplashPageState extends State<SplashPage>{


  bool hadInit = false;

  ///当组件的状态改变的时候就会调用didUpdateWidget,比如调用了setState.
  //
  //实际上这里flutter框架会创建一个新的Widget,绑定本State，并在这个函数中传递老的Widget。
  //
  //这个函数一般用于比较新、老Widget，看看哪些属性改变了，并对State做一些调整。
  //
  //需要注意的是，涉及到controller的变更，需要在这个函数中移除老的controller的监听，并创建新controller的监听。
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(hadInit){
      return ;
    }
    hadInit = true;
    AppManager.initApp(context).then((_){
      Future.delayed(Duration(seconds: 2),(){
        NavigatorUtils.pushReplacementNamed(context, NavigatorUtils.ROUTE_HOME);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: FractionalOffset.center,
              child: Padding(
                padding: EdgeInsets.only(bottom:150.0),
                child: Image.asset(
                  "images/gank.png",
                  width: 100,
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.all(20.0),
                child: Text(
                  '${DateTime.now().year}@gank.io',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontFamily: "WorkSansMedium"
                  ),
                ),
              ),
            )
          ],
        ),
      )

    );
  }

}

