import 'package:flutter/material.dart';
import 'package:flutter_app/plugin/toast_plugin_demo.dart';


void main(){
  runApp(PopApp());
}


class PopApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "pop window",
      home: Scaffold(
        appBar: AppBar(title: Text("show pop"),),
        body:  PopHome(),
      )
     ,
    );
  }

}

class PopHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PopHomeState();
  }
  
}

class PopHomeState extends State<PopHome>{
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        Container(
          width: 100,
          height: 60,
          child: PopupMenuButton<String>(
              child: Center(child: Text("pop"),),
              onSelected: (str){
                FlutterToast.toast(str);
              },
               itemBuilder: (context){
                return ["1","2","3"].map((str){
                  return PopupMenuItem<String>(
                    child: Text(str),
                    value: str,
                  );
                }).toList();
              }),
        ),


      ],
    );
  }
}















