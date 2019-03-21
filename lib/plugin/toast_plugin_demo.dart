import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterToast {
  static const MethodChannel _channel = const MethodChannel("my/toast");

  static Future<bool> toast(String content) async {
    var args = {"content": content};

    return await _channel.invokeMethod("toast", args);
  }
}

void main() {
  runApp(MaterialApp(
    title: "toast",
    home: Scaffold(
      appBar: AppBar(
        title: Text("ShowToast"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            FlutterToast.toast("clicked");
          },
          child: Text("test show toast"),
        ),
      ),
    ),
  ));
}
