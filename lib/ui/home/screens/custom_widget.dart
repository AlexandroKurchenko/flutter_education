import 'dart:math' as Math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({Key key}) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

const TWO_PI = 3.14 * 2;
const size = 150.0;
const _radius = 70.0;

class _CustomWidgetState extends State<CustomWidget>
    with TickerProviderStateMixin {
  AnimationController _progressController;
  Animation<double> _progressAnimation;
  AnimationController _customPaintController;
  Animation<double> _customPaintAnimation;
  int _percentage = 0;

  @override
  void initState() {
    _progressController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_progressController)
          ..addListener(() {
            setState(() {
              _percentage = (_progressAnimation.value * 100).ceil();
            });
          });
    _progressController.forward();

    _customPaintController =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    var start = -Math.pi + (Math.pi / 2);
    var end = Math.pi + (Math.pi / 2);
    _customPaintAnimation =
        Tween<double>(begin: start, end: end).animate(_customPaintController)
          ..addListener(() {
            setState(() {});
          });
    _customPaintController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.restore), onPressed: () => _performAnimation()),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                kIsWeb
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(top: 10),
                        width: size,
                        height: size,
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return SweepGradient(
                                    startAngle: 0.0,
                                    endAngle: TWO_PI,
                                    stops: [
                                      _progressAnimation.value,
                                      _progressAnimation.value
                                    ],
                                    // 0.0 , 0.5 , 0.5 , 1.0
                                    center: Alignment.center,
                                    colors: [
                                      Colors.blue,
                                      Colors.transparent
                                    ]).createShader(rect);
                              },
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: size - 40,
                                height: size - 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  "$_percentage%",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                kIsWeb
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(top: 10),
                        width: size,
                        height: size,
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return SweepGradient(
                                    startAngle: 0.0,
                                    endAngle: TWO_PI,
                                    stops: [
                                      _progressAnimation.value,
                                      _progressAnimation.value
                                    ],
                                    center: Alignment.center,
                                    colors: [
                                      Colors.blue,
                                      Colors.transparent
                                    ]).createShader(rect);
                              },
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: Image.asset(
                                                "images/radial_scale.png")
                                            .image)),
                              ),
                            ),
                            Center(
                              child: Container(
                                width: size - 40,
                                height: size - 40,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Center(
                                    child: Text(
                                  "$_percentage%",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                kIsWeb
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(top: 10),
                        width: size,
                        height: size,
                        child: Stack(
                          children: [
                            ShaderMask(
                              shaderCallback: (rect) {
                                return LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [
                                      _progressAnimation.value,
                                      _progressAnimation.value
                                    ],
                                    colors: [
                                      Colors.green,
                                      Colors.amber.withAlpha(100)
                                    ]).createShader(rect);
                              },
                              child: Container(
                                width: size,
                                height: size,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.asset(
                                                "images/radial_scale.png")
                                            .image)),
                              ),
                            )
                          ],
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(top: 40),
                  width: size,
                  height: size,
                  child: CustomPaint(
                    // foregroundPainter: PointPainter(
                    //     radius: _radius, radians: _customPaintAnimation.value),
                    painter: PentagonBackgroundStatisticPainter(_radius),
                    child: Container(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 50),
                  width: size,
                  height: size,
                  child: CustomPaint(
                    foregroundPainter: PointPainter(
                        radius: _radius, radians: _customPaintAnimation.value),
                    painter: CirclePainter(radius: _radius),
                    child: Container(),
                  ),
                ),
                SizedBox(width: 0.0, height: 50)
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _progressController.dispose();
    _customPaintController.dispose();
    super.dispose();
  }

  void _performAnimation() {
    if (_progressController.status == AnimationStatus.forward ||
        _progressController.status == AnimationStatus.completed) {
      _progressController.reverse();
    } else {
      _progressController.forward();
    }

    if (_customPaintController.status == AnimationStatus.forward ||
        _customPaintController.status == AnimationStatus.completed) {
      _customPaintController.reverse();
    } else {
      _customPaintController.forward();
    }
  }
}

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

class PentagonBackgroundStatisticPainter extends CustomPainter {
  final double radius;
  List<PentagonOffsets> pentagons = [];

  PentagonBackgroundStatisticPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    final radians = -0.3; // to center starting point
    final int sides = 5; //for Pentagon
    if (pentagons.isEmpty) {
      pentagons.addAll(_getPentagons(radius, sides, center));
      print("Pentagons = ${pentagons.toString()} ");
    }

    // ------------ start drawing Pentagon
    var pentagonPaint = Paint()
      ..color = Colors.indigo
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var angle = (Math.pi * 2) / sides;
    // var pentagonPath = Path();

    // final Offset pointOnCircleWithPadding = Offset(
    //   radius * Math.cos(radians) + center.dx,
    //   radius * Math.sin(radians) + center.dy,
    // );
    // pentagonPath.moveTo(
    //     pointOnCircleWithPadding.dx, pointOnCircleWithPadding.dy);
    var first = pentagons.first;
    // pentagons.forEach((pentagon) {
    var pentagonPath = Path();
    print('pentagons.first = ${first.radius}');
    for (int i = 0; i < first.pentagons.length; i++) {
      final offset = first.pentagons[i];
      if (i == 0) {
        pentagonPath.moveTo(offset.x, offset.y);
      }
      pentagonPath.lineTo(offset.x, offset.y);
    }

    pentagonPath.close();
    canvas.drawPath(pentagonPath, pentagonPaint);
    // });
    // for (int i = 1; i <= sides; i++) {
    //   double x = radius * Math.cos(radians + angle * i) + center.dx;
    //   double y = radius * Math.sin(radians + angle * i) + center.dy;
    //   pentagonPath.lineTo(x, y);
    // }
    // pentagonPath.close();
    // canvas.drawPath(pentagonPath, pentagonPaint);
    // ------------ end of drawing Pentagon

    // ------------ start drawing lines to center
    var linePaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    for (int i = 1; i <= sides; i++) {
      var linePath = Path();
      linePath.moveTo(center.dx, center.dy);
      double x = radius * Math.cos(radians + angle * i) + center.dx;
      double y = radius * Math.sin(radians + angle * i) + center.dy;
      linePath.lineTo(x, y); //end of drawing
      linePath.close();
      canvas.drawPath(linePath, linePaint);
    }
    // ------------ end drawing lines to center
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  List<PentagonOffsets> _getPentagons(double radius, int sides, Offset center) {
    final List<PentagonOffsets> offsets = [];
    final List<PositionHolder> pentagons = <PositionHolder>[];
    final int length = 5;
    final radiusStep = radius / length;
    final radians = -0.3;
    var angle = (Math.pi * 2) / sides;
    for (int i = 0; i <= length; i++) {
      final pentagonRadius = radius - (radiusStep * i);
      for (int i = 0; i <= sides; i++) {
        double x = pentagonRadius * Math.cos(radians + angle * i) + center.dx;
        double y = pentagonRadius * Math.sin(radians + angle * i) + center.dy;
        pentagons.add(PositionHolder(x, y));
      }
      offsets.add(PentagonOffsets(pentagons, pentagonRadius));
    }
    return offsets;
  }
}

class PentagonOffsets {
  final List<PositionHolder> pentagons;
  final double radius;

  PentagonOffsets(this.pentagons, this.radius);

  @override
  String toString() {
    return '{pentagons: $pentagons, radius: $radius}';
  }
}

class PositionHolder {
  final double x;
  final double y;

  PositionHolder(this.x, this.y);

  @override
  String toString() {
    return '{x: $x, y: $y}';
  }
}
