import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/login/login_mamager.dart';
import 'package:flutter_app/pra_project/login/login_page.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MinePageState();
  }
}

class _MinePageState extends State<MinePage> {
  String _userName = "";

  Widget _buildItem(IconData iconData, String title, Function callBack) {
    return InkWell(
      onTap: callBack,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.blue,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.black),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  void _likeArticle() {
    LoginManager.isLogin().then((isLogin) {
      if (isLogin) {
      } else {
        _toLogin();
      }
    });
  }

  void _toLogin() {
    LoginPage.toLogin(context);
  }

  void _logout() async {
    await LoginManager.clearLoginInfo();

    setState(() {
      _userName = "请登录";
    });
  }

  @override
  void initState() {
    super.initState();
    LoginManager.getUserName().then((userName) {
      if (userName == "" || userName == null) {
        setState(() => _userName = "请登录");
      } else {
        setState(() => _userName = userName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 15, bottom: 8),
          child: Center(
            child: Image.asset(
              "images/ic_launcher_round.png",
              width: 100,
              height: 100,
            ),
          ),
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text(
            _userName,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            if (await LoginManager.isLogin() == true) {
            } else {
              _toLogin();
            }
          },
        ),
        _buildItem(Icons.favorite, "喜欢的文章", _likeArticle),
        _buildItem(Icons.info, "退出登录", _logout),
      ],
    );
  }
}
