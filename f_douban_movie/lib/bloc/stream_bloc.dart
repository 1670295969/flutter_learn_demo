import 'dart:async';

import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class IncrementBloc implements BlocBase {
  int _counter;

  StreamController<int> _counterController = StreamController<int>();

  StreamSink<int> get _inAdd => _counterController.sink;

  Stream<int> get outCounter => _counterController.stream;

  StreamController _actionController = StreamController();

  StreamSink get incrementCounter => _actionController.sink;

  IncrementBloc() {
    _counter = 0;
    _actionController.stream.listen(_handleLogic);
  }

  void _handleLogic(data) {
    _counter = _counter + 1;
    _inAdd.add(_counter);
  }

  @override
  void dispose() {
    _actionController.close();
    _counterController.close();
  }
}


class BlocProvider<T extends BlocBase> extends StatefulWidget{

  Widget child;
  final T bloc;

  BlocProvider({Key key,this.child,this.bloc}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    return _BlocProviderState();
  }

}

class _BlocProviderState extends State<BlocProvider>{
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

}





