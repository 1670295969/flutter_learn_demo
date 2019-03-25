import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController;
  TextEditingController _pwdNameController;
  GlobalKey<ScaffoldState> scaffoldKey;

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
            "登录",
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
  void _login(){

  }

  void _toRegister(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            _headIcon(),
            _textInput("用户名", false, _userNameController),
            _textInput("密码", true, _pwdNameController),
            _btns(),
          ],
        ),
      ),
    );
  }
}
