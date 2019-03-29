

import 'package:flutter/material.dart';
import 'package:flutter_app/redux_demo/state.dart';
import 'package:flutter_app/redux_demo/under_screen.dart';
import 'package:flutter_redux/flutter_redux.dart';

class TopScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TopScreenState();
  }

}

class _TopScreenState extends State<TopScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Top Screen"),
      ),
      body: Center(
        child: StoreConnector<CountState,int>(
          converter: (store)=>store.state.count,
          builder: (ctx,count){
            return Text(
              count.toString(),
              style: Theme.of(ctx).textTheme.display1,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          return UnderScreen();
        }));
      },
      child: Icon(Icons.favorite),
      ),
    );
  }

}
