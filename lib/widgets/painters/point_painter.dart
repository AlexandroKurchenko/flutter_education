import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PointPainter extends CustomPainter {
  final double radius;
  final double radians;

  PointPainter({this.radius, this.radians});

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    // print('radians=$radians');
    // ------------ start drawing of point on circle(CirclePainter)
    var pointPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.square;

    final Offset pointOnCircle = Offset(
      radius * Math.cos(radians) + center.dx,
      radius * Math.sin(radians) + center.dy,
    );

    // For showing the point moving on the circle
    var circleRadius = 10.0;
    canvas.drawCircle(pointOnCircle, circleRadius, pointPaint);
    // ------------ end drawing of point on circle(CirclePainter)

    // ------------ start drawing line from center to point(pointOnCircle)
    var linePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var linePath = Path();
    linePath.moveTo(
        center.dx, center.dy); // move start from where start line drawing
    linePath.lineTo(pointOnCircle.dx, pointOnCircle.dy); //end of drawing
    linePath.close();
    canvas.drawPath(linePath, linePaint);
    // ------------ end drawing line from center to point(pointOnCircle)

    // ------------ start drawing Pentagon
    var pentagonPaint = Paint()
      ..color = Colors.indigo
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    num sides = 5; //for Pentagon
    var angle = (Math.pi * 2) / sides;
    var outerRadius = radius + 20;
    var pentagonPath = Path();

    final Offset pointOnCircleWithPadding = Offset(
      outerRadius * Math.cos(radians) + center.dx,
      outerRadius * Math.sin(radians) + center.dy,
    );
    pentagonPath.moveTo(
        pointOnCircleWithPadding.dx, pointOnCircleWithPadding.dy);

    for (int i = 1; i <= sides; i++) {
      double x = outerRadius * Math.cos(radians + angle * i) + center.dx;
      double y = outerRadius * Math.sin(radians + angle * i) + center.dy;
      pentagonPath.lineTo(x, y);
    }
    pentagonPath.close();
    canvas.drawPath(pentagonPath, pentagonPaint);
    // ------------ end of drawing Pentagon
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
