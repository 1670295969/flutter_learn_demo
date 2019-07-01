import 'dart:async';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class User {
  String name = "";
  int age = 0;
  StreamController<User> controller;

  void change() {
    name = "${age}";
    age++;
    print(name);
//    User u = User();
//    u.name = name;
//    u.age = age;
    controller.add(this);
  }
}

void main() {
  User user = User();
  user.controller = StreamController<User>();
  runApp(StreamProvider.controller(
    builder: (_) => user.controller,
    initialData: user,
    updateShouldNotify: (old, newUser) {
      return old.age == newUser.age;
    },
    child: UserApp(),
  ));
}

class UserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "provider",
      home: UserHome(),
    );
  }
}

class UserHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserHomeState();
  }
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("provider"),
      ),
      body: ChildWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<User>(context).change();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ChildWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(builder: (_, count, w) {
      return Text("${count.name}_${count.age}_$w");
    });
  }
}
