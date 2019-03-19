
import 'package:flutter/material.dart';
import 'dart:math' as math;

class _FinishAnimationPainter extends CustomPainter{

  static const Offset _p1 = Offset(0.0, 0.5);
  static const Offset _p2 = Offset(0.3, 0.8);
  static const Offset _p3 = Offset(0.75, 0.35);

  final Color color;
  final double value;
  final double line1StartValue;
  final double line1EndValue;
  final double line2EndValue;

  final double _arcStart;
  final double _arcSweep;
  final Offset _line1Start;
  final Offset _line1End;
  final Offset _line2End;

  _FinishAnimationPainter(this.color, this.value, this.line1StartValue,
      this.line1EndValue, this.line2EndValue)
      : _arcStart = math.pi + math.pi * 2 * value * 2,
        _arcSweep = -value * math.pi * 2,
        _line1Start = _p1 - (_p1 - _p2) * line1StartValue,
        _line1End = _p1 - (_p1 - _p2) * line1EndValue,
        _line2End = _p2 - (_p2 - _p3) * line2EndValue;



  @override
  void paint(Canvas canvas, Size size) {
    double side = math.min(size.width, size.height);
    Paint paint = Paint()
      ..color = color ?? Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    if (_line1Start != _line1End) {
      canvas.drawLine(_line1Start * side, _line1End * side, paint);
    }
    if (_p2 != _line2End) {
      canvas.drawLine(_p2 * side, _line2End * side, paint);
    }
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(_FinishAnimationPainter other) {
    return value != other.value;
  }

}

