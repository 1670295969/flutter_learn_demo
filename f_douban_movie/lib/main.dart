import 'package:flutter/material.dart';

import 'find/find.dart';
import 'home/HomeWidget.dart';
import 'mine/mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '豆瓣电影'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  BottomNavigationBarItem _createNavItem(IconData iconData, String title) {
    return BottomNavigationBarItem(icon: Icon(iconData), title: Text(title));
  }

  void _onItemTaped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetItem = [
    HomeWidget(),
    MoviesWidget(),
    MineWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetItem[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          _createNavItem(Icons.school, "热映"),
          _createNavItem(Icons.panorama_fish_eye, "找片"),
          _createNavItem(Icons.people, "我的"),
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTaped,
      ),
    );
  }
}
