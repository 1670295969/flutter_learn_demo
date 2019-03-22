import 'package:flutter/material.dart';

class StateFish extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        image: const DecorationImage(
            image: const NetworkImage(
              'https://gw.alicdn.com/tfs/TB1CgtkJeuSBuNjy1XcXXcYjFXa-906-520.png',
            ),
            fit: BoxFit.contain),
        borderRadius: const BorderRadius.only(
            topLeft: const Radius.circular(3.0),
            topRight: const Radius.circular(6.0),
            bottomLeft: const Radius.circular(9.0),
            bottomRight: const Radius.circular(0.0)),
      ),
      child: Text(""),
    );
  }
}

class FlexWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 40.0,
          height: 60.0,
          color: Colors.black,
          child: Center(
            child: Text("left"),
          ),
        ),
        Container(
          width: 50.0,
          height: 40.0,
          color: Colors.blue,
          child: const Center(
            child: Text("middle"),
          ),
        ),
        Container(
          width: 60.0,
          height: 40.0,
          color: Colors.grey,
          child: const Center(
            child: Text("right"),
          ),
        )
      ],
    );
  }
}

class StackWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}


