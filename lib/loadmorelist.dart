import 'package:flutter/material.dart';

class MyListLoadMorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

class _MyListLoadMorePage extends State<MyListLoadMorePage> {
  List<int> items = List.generate(10, (i) => i);
  ScrollController _scrollController = ScrollController();
  bool isPrefromingRequest = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Infinite ListView")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if(index == items.length){
            return _buildProgressIndicator();
          }
          return ListTile(
            title: Text("number_$index"),
          );
        },
        controller: _scrollController,
      ),
    );
  }

  Future<List<int>> fakeRequest(int from, int to) async {
    return Future.delayed(Duration(seconds: 2), () {
      return List.generate(to - from, (i) => i + from);
    });
  }

  _getMoreData() async {
    if (!isPrefromingRequest) {
      setState(() {
        isPrefromingRequest = true;
      });

      List<int> newEntries = await fakeRequest(items.length, items.length + 10);

      if(newEntries.isEmpty){
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if(offsetFromBottom < edge){
          _scrollController.animateTo(_scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(microseconds: 500), curve: Curves.easeOut);
        }
      }

      setState(() {
        items.addAll(newEntries);
        isPrefromingRequest = false;
      });
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: isPrefromingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }


}
