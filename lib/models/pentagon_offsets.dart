import 'package:flutter_app/models/position_holder.dart';

class PentagonOffsets {
  final List<PositionHolder> pentagons;
  final double radius;

  PentagonOffsets(this.pentagons, this.radius);

  @override
  String toString() {
    return '{pentagons: $pentagons, radius: $radius}';
  }
}
