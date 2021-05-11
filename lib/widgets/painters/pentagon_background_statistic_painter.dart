import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/pentagon_offsets.dart';
import 'package:flutter_app/models/position_holder.dart';
import 'package:flutter_app/utils/pentagon_generator.dart';

class PentagonBackgroundStatisticPainter extends CustomPainter {
  final double radius;
  List<PentagonOffsets> pentagons = [];

  PentagonBackgroundStatisticPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final int sides = 5; //for Pentagon

    var pentagonPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    if (pentagons.isEmpty) {
      pentagons.addAll(getPentagons(radius, sides, center));
    }

    // ------------ start drawing Pentagons

    for (int s = 0; s < pentagons.length; s++) {
      var pentagonPath = Path();

      for (int i = 0; i < pentagons[s].pentagons.length; i++) {
        final offset = pentagons[s].pentagons[i];
        if (i == 0) {
          pentagonPath.moveTo(offset.x, offset.y);
        }
        if (i == sides - 1 && (sides - s > 0)) {
          _drawNumberText("${sides - s}", offset, canvas);
        }
        pentagonPath.lineTo(offset.x, offset.y);
      }

      pentagonPath.close();
      canvas.drawPath(pentagonPath, pentagonPaint);
    }
    // ------------ end of drawing Pentagon
    _drawLinesToCenter(center, canvas, sides, pentagonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawNumberText(String text, PositionHolder offset, Canvas canvas) {
    // ------------ start draw item numbers
    final textSpan = TextSpan(
        text: "$text", style: TextStyle(color: Colors.white, fontSize: 8));
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: 100);
    Offset pointOnCircle =
        Offset(offset.x - 10, offset.y - 15); // -10 and -15 are transition

    textPainter.paint(canvas, pointOnCircle);
    // ------------ end draw item numbers
  }

  void _drawLinesToCenter(
      Offset center, Canvas canvas, int sides, Paint pentagonPaint) {
    // ------------ start drawing lines to center
    final angle = (Math.pi * 2) / sides;
    final radians = -0.3; // to center starting point
    for (int i = 0; i < sides; i++) {
      var linePath = Path();
      linePath.moveTo(center.dx, center.dy);
      double x = radius * Math.cos(radians + angle * i) + center.dx;
      double y = radius * Math.sin(radians + angle * i) + center.dy;
      linePath.lineTo(x, y); //end of drawing
      linePath.close();
      canvas.drawPath(linePath, pentagonPaint);
    } // ------------ end drawing lines to center
  }
}
