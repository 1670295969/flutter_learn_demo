
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'i18n_suport.dart';

void main()=>runApp(I18nApp());

class I18nApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      onGenerateTitle: (context){
        return DemoLocalizations.of(context).currentLocalized.task_title;
      },
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale("zh","CH"),
        const Locale('en',"US"),
      ],
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(new Duration(days: 30)),
        lastDate: new DateTime.now().add(new Duration(days: 30))).then((v) {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(DemoLocalizations.of(context).currentLocalized.title_bar_title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              DemoLocalizations.of(context).currentLocalized.click_tip,                          // 此处3
            ),
            new Text(
              '$_counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: DemoLocalizations.of(context).currentLocalized.inc,                           // 此处4
        child: new Icon(Icons.add),
      ),
    );
  }
}

