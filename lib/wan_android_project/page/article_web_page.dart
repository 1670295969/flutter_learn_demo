import 'package:flutter/material.dart';
import 'package:flutter_app/wan_android_project/anim/anim.dart';
//import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ArticleWebPage extends StatefulWidget {
  final String title;
  final String url;

  ArticleWebPage(this.title, this.url);

  static push(BuildContext context, String title, String url) {
    Navigator.of(context).push(
      PageRouteBuilder(pageBuilder: (ctx, animation, secondaryAnimation) {
        return ArticleWebPage(title, url);
      }, transitionsBuilder: (ctx, animation, secondaryAnimation, child) {
        return AnimUtils.createTransition(animation, child);
      }),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return _ArticleWebPageState();
  }
}

class _ArticleWebPageState extends State<ArticleWebPage> {
//  final flutterWebViewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
//    flutterWebViewPlugin.onDestroy.listen((_) {
//      Navigator.of(context).pop();
//    });
  }

  @override
  Widget build(BuildContext context) {
    return null;
//    debugPrint("web url ${widget.url}");
////    return WebviewScaffold(
//      url: widget.url,
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      withZoom: false,
//      withJavascript: true,
//      withLocalStorage: true,
//    );
  }
}
