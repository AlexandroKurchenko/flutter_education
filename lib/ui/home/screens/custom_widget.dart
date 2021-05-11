import 'dart:math' as Math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/widgets/painters/circle_painter.dart';
import 'package:flutter_app/widgets/painters/pentagon_background_statistic_painter.dart';
import 'package:flutter_app/widgets/painters/pentagon_statistic_painter.dart';
import 'package:flutter_app/widgets/painters/point_painter.dart';

class CustomWidget extends StatefulWidget {
  const CustomWidget({Key key}) : super(key: key);

  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

const TWO_PI = 3.14 * 2;
const size = 150.0;
const customPaintSize = 400.0;
const _radius = 140.0;

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
                FittedBox(
                    child: SizedBox(
                        child: Container(
                          color: Colors.black87,
                          child: CustomPaint(
                            foregroundPainter:
                                PentagonStatisticPainter(_radius),
                            painter:
                                PentagonBackgroundStatisticPainter(_radius),
                            child: Container(),
                          ),
                        ),
                        width: customPaintSize,
                        height: customPaintSize)),
                FittedBox(
                    child: SizedBox(
                        child: Padding(
                            child: CustomPaint(
                              foregroundPainter: PointPainter(
                                  radius: _radius,
                                  radians: _customPaintAnimation.value),
                              painter: CirclePainter(radius: _radius),
                              child: Container(),
                            ),
                            padding: EdgeInsets.only(top: _radius)),
                        width: customPaintSize,
                        height: customPaintSize)),
                SizedBox(width: 0.0, height: _radius / 2)
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
