import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(CounterWidget());

class CounterWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CounterWidgetState();
  }
}

class CounterWidgetState extends State<CounterWidget> {
  static final StreamController<int> _streamController = StreamController();
  static final StreamSink<int> _sink = _streamController.sink;
  static final Stream<int> _stream = _streamController.stream;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Flutter 响应式编程")),
        body: StreamBuilder(
          stream: _stream,
          initialData: 0,
          builder: (context, snapShot) {
            return Center(
              child: Text("${snapShot.data}"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _sink.add(++_count);
          },
        ),
      ),
    );
  }
}
