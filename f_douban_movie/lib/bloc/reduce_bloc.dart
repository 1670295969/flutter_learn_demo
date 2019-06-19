import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

//创建state
class CountState {
  final int count;

  CountState(this.count);

  factory CountState.initState() {
    return CountState(0);
  }
}

//创建action
enum CountAction { inc }

//创建reducer 状态生成器

CountState reducer(CountState state, action) {
  if (action == CountAction.inc) {
    return CountState(state.count + 1);
  }

  return CountState(state.count);
}

//store

void main() {
  final store =
      Store<CountState>(reducer, initialState: CountState.initState());

  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<CountState> store;

  MyApp(this.store);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<CountState>(
      store: store,
      child: MaterialApp(
        title: "Redux",
        home: TopWidget(),
      ),
    );
  }
}

class TopWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("redux"),
      ),
      body: StoreConnector<CountState, int>(
        converter: (store) => store.state.count,
        builder: (context, count) {
          return Text("$count");
        },
      ),
      floatingActionButton: StoreConnector<CountState, VoidCallback>(
          builder: (context, callback) {
        return FloatingActionButton(
          onPressed: callback,
          child: Icon(Icons.add),
        );
      }, converter: (store) {
        return () => store.dispatch(CountAction.inc);
      }),
    );
  }
}
