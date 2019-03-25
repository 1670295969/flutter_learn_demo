import 'package:flutter/material.dart';
import 'package:flutter_app/pra_project/login/login_mamager.dart';
import 'package:flutter_app/pra_project/net/net_storage.dart';

class LoginPage extends StatefulWidget {

  static Future<dynamic> toLogin(BuildContext context) async{
    return Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
      return LoginPage();
    }));
  }

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController;
  TextEditingController _pwdNameController;
  GlobalKey<ScaffoldState> scaffoldKey;

  bool _isLogining = false;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    _userNameController = TextEditingController();
    _pwdNameController = TextEditingController();
  }

  Widget _headIcon() {
    return Center(
      child: Icon(
        Icons.account_circle,
        color: Colors.blue,
        size: 80,
      ),
    );
  }

  Widget _textInput(
      String title, bool isPassword, TextEditingController controller) {
    return TextField(
      decoration: InputDecoration(labelText: title),
      obscureText: isPassword,
      controller: controller,
    );
  }

  Widget _btns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RaisedButton(
          child: Text(
            "登录",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            _login();
          },
        ),
        RaisedButton(
          child: Text(
            "注册",
            style: TextStyle(color: Colors.white),
          ),
          color: Colors.blue,
          onPressed: () {
            _toRegister();
          },
        )
      ],
    );
  }

  void _login() {
    setState(() => _isLogining = true);
    var userName = _userNameController.text;
    var password = _pwdNameController.text;

    NetStorage.login(userName, password).then((data) {
      LoginManager.saveUserInfo(userName);
      setState(() => _isLogining = false);
    }).catchError((e) {
      setState(() => _isLogining = false);
    });
  }

  void _toRegister() {}

  Widget _loginPageView() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          _headIcon(),
          _textInput("用户名", false, _userNameController),
          _textInput("密码", true, _pwdNameController),
          _btns(),
        ],
      ),
    );
  }

  Widget _fillLoginView() {
    if (_isLogining) {
      return Stack(
        children: <Widget>[
          _loginPageView(),
          Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          )
        ],
      );
    } else {
      return _loginPageView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: _fillLoginView(),
    );
  }
}
