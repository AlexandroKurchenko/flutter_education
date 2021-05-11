import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CirclePainter extends CustomPainter {
  final double radius;

  CirclePainter({this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.redAccent;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    paint.strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
