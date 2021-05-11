import 'dart:math' as Math;

import 'package:flutter/painting.dart';
import 'package:flutter_app/models/pentagon_offsets.dart';
import 'package:flutter_app/models/position_holder.dart';

List<PentagonOffsets> getPentagons(double radius, int sides, Offset center) {
  final List<PentagonOffsets> offsets = [];

  final int length = 5;
  final radiusStep = radius / length;
  final radians = -0.3;
  var angle = (Math.pi * 2) / sides;
  for (int i = 0; i <= length; i++) {
    final List<PositionHolder> pentagons = <PositionHolder>[];
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
