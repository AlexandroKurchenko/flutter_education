import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/models/pentagon_offsets.dart';
import 'package:flutter_app/utils/pentagon_generator.dart';

class PentagonStatisticPainter extends CustomPainter {
  final double radius;
  final List<int> statisticPentagon = [2, 2, 2, 3, 4, 5];
  List<PentagonOffsets> pentagons = [];

  PentagonStatisticPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final orange = Colors.orange;
    final orangeWithAlpha = Colors.orange.withAlpha(100);
    final Offset center = Offset(size.width / 2, size.height / 2);
    final int sides = 5; //for Pentagon

    if (pentagons.isEmpty) {
      pentagons.addAll(getPentagons(radius, sides, center));
    }
    var pentagonPaint = Paint()
      ..color = orange
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var pentagonFillPaint = Paint()
      ..color = orangeWithAlpha
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    // ------------ start drawing Pentagons
    final pentagonPath = Path();
    for (int i = 0; i < pentagons.length; i++) {
      final offset = pentagons[i].pentagons[statisticPentagon[i]];
      if (i == 0) {
        pentagonPath.moveTo(offset.x, offset.y);
      }
      pentagonPath.lineTo(offset.x, offset.y);
    }
    pentagonPath.close();
    canvas.drawPath(pentagonPath, pentagonPaint);
    canvas.drawPath(pentagonPath, pentagonFillPaint);
    // ------------ end of drawing Pentagon
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
