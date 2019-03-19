

import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("text"),
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(4.0),
      width: 80.0,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5.0),
      ),
    );
  }

}
