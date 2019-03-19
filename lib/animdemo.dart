import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'dart:async';


class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }

}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  CurvedAnimation curve;
  Animation animationValue;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 5000),
      vsync: this,
    );

    curve = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    controller.forward();
    animationValue = Tween(begin: 0.0, end: 200.0).animate(controller)
      ..addListener(() {
        print("value=${animationValue.value}");
      });
  }


  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      child: FlutterLogo(size: 200.0,),
      scale: curve,
    );
  }

}


class AnimationDemoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }

}


class _AnimationDemoState extends State<AnimationDemoView>
    with SingleTickerProviderStateMixin {

  static const padding = 0.0;
  AnimationController controller;
  Animation<double> left;

  @override
  void initState() {
    super.initState();
    // 只有在 initState 执行完，我们才能通过 MediaQuery.of(context) 获取   
    //  // mediaQueryData。这里通过创建一个 Future 从而在 Dart 事件队列里插入   
    //  // 一个事件，以达到延后执行的目的（类似于在 Android 里 post 一个 Runnable）    
    //  关于 Dart 的事件队列，读者可以参考 https://webdev.dartlang.org/articles/performance/event-loop
    Future(_initState);
  }


  void _initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    final mediaQueryData = MediaQuery.of(context);
    final displayWidth = mediaQueryData.size.width;
    left =
    Tween(begin: padding, end: displayWidth - padding).animate(controller)
      ..addListener(() {
        setState(() {
          //TODO
        });
      })
      ..addStatusListener((state) {
        if (state == AnimationStatus.completed) {
          controller.reverse();
        } else if (state == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final unit = 24.0;
    final marginLeft = left == null ? padding : left.value;
    final unitizedLeft = (marginLeft - padding) / unit;
    final unitizedTop = math.sin(unitizedLeft);
    final marginTop = (unitizedTop + 1) * unit + padding;
    return Container(
      margin: EdgeInsets.only(left: marginLeft, top: marginTop),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(7.5),

        ),
        width: 15.0,
        height: 15.0,

      ),
    );
  }


}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: "anim demo",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Anim demo"),
        ),
        body: AnimationDemoView(),
      ),
    );
  }
}











































































