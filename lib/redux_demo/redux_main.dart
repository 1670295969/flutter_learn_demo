import 'package:flutter/material.dart';
import 'package:flutter_app/redux_demo/state.dart';
import 'package:flutter_app/redux_demo/top.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store =
      Store<CountState>(reducer, initialState: CountState.initState());
  runApp(MyReduxApp(store));
}

class MyReduxApp extends StatelessWidget {
  final Store<CountState> store;

  MyReduxApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: TopScreen(),
      ),
    );
  }
}
