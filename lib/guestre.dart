

import 'package:flutter/material.dart';

class StartWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}


class FirstScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FirstScreenState();
  }




}



class _FirstScreenState extends State<FirstScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title:Text("Nav deme")),
      body: Center(
        child: RaisedButton(
            child: Text("First Screen"),
            onPressed: () async {
              var msg = await Navigator.push(context,
              MaterialPageRoute(builder: (_)=>SecondScreen())
              );
            }),
      ),
    );
  }

}


class SecondScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SecondScreenState();
  }

}

class _SecondScreenState extends State<SecondScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Second")),
      body: Center(
        child: RaisedButton(
          child: Text("Second_page"),
          onPressed: ()=> Navigator.pop(context,"back msg"),
        ),
      ),
    );
  }

}
























