import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/gank_project/event/event_refresh_new.dart';
import 'package:flutter_app/gank_project/event/event_show_history_date.dart';
import 'package:flutter_app/gank_project/manager/app_manager.dart';
import 'package:flutter_app/gank_project/utils/time_utils.dart';

class HistoryDate extends StatefulWidget {
  final List _historyData;

  HistoryDate(this._historyData);

  @override
  State<StatefulWidget> createState() {
    return _HistoryDateState();
  }
}

class _HistoryDateState extends State<HistoryDate>
    with TickerProviderStateMixin {
  Animation<Offset> _historyDateDetailsPosition;

  AnimationController _controllerHistoryDate;

  Animation<double> _historyDateContentsOpactiy;

  Animatable<Offset> _historyDataDetailsTween;

  String _currentDate;

  ///是否显示历史日期一栏
  bool _showHistoryDate = false;

  @override
  void initState() {
    super.initState();

    _controllerHistoryDate = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );

    _historyDateContentsOpactiy = CurvedAnimation(
      parent: ReverseAnimation(_controllerHistoryDate),
      curve: Curves.fastLinearToSlowEaseIn,
    );

    _historyDataDetailsTween = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.fastOutSlowIn));
    _historyDateDetailsPosition =
        _controllerHistoryDate.drive(_historyDataDetailsTween);

    if (widget._historyData != null && widget._historyData.isNotEmpty) {
      _currentDate = widget._historyData[0];
    }

    AppManager.eventBus.on<ShowHistoryDateEvent>().listen((event) {
      if (mounted) {
        if (event.forceHide) {
          _showHistoryDate = false;
        } else {
          _showHistoryDate = !_showHistoryDate;
        }

        if (_showHistoryDate) {
          _controllerHistoryDate.forward();
        } else {
          _controllerHistoryDate.reverse();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _historyDateDetailsPosition,
      child: FadeTransition(
        opacity: ReverseAnimation(_historyDateContentsOpactiy),
        child: Card(
          elevation: 5,
          margin: EdgeInsets.all(0),
          child: Container(
            color: Colors.white,
            height: 50,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget._historyData == null
                    ? 0
                    : widget._historyData.length,
                itemBuilder: (ctx, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentDate = widget._historyData[0];
                      });
                      AppManager.eventBus
                          .fire(RefreshNewPageEvent(_currentDate));
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              TimeUtils.getDay(widget._historyData[i]),
                              style: Theme.of(ctx).textTheme.body2.copyWith(
                                  fontSize: 18,
                                  color:
                                      (widget._historyData[i] == _currentDate)
                                          ? Theme.of(ctx).primaryColor
                                          : Colors.black),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 3, bottom: 2),
                              child: Text(
                                TimeUtils.getWeekDay(widget._historyData[i]),
                                style: Theme.of(ctx).textTheme.body2.copyWith(
                                    fontSize: 8,
                                    color:
                                        (widget._historyData[i] == _currentDate)
                                            ? Theme.of(ctx).primaryColor
                                            : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
