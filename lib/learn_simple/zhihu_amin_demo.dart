//https://zhuanlan.zhihu.com/p/47156664

import 'package:flutter/material.dart';
import 'dart:math' as math;

class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;

  DemoPainter(this._arcStart, this._arcSweep);

  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  //需要重新绘制的条件
  @override
  bool shouldRepaint(DemoPainter oldDelegate) {
    return _arcStart != oldDelegate._arcStart ||
        _arcSweep != oldDelegate._arcSweep;
  }
}

class AnimDemoWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimDemoWidgetState();
  }
}

class _AnimDemoWidgetState extends State<AnimDemoWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )
      ..repeat()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DemoPainter(
        Tween(begin: math.pi * 1.5, end: math.pi * 3.5)
            .chain(CurveTween(curve: Interval(0.5, 1.0,curve: Curves.linear)))
            .evaluate(_controller),
        math.sin(Tween(begin: 0.0, end: math.pi).evaluate(_controller)) *
            math.pi,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: "custom view",
    home: Scaffold(
      appBar: AppBar(
        title: Text("custom view"),
      ),
      body: Container(
        child: AnimDemoWidget(),
        height: 200.0,
        width: 200.0,
        color: Colors.deepOrange,
        padding: EdgeInsets.all(30.0),
      ),
    ),
  ));
}
