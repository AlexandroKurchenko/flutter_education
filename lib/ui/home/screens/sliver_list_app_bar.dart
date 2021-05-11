import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliverListAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text("SliverAppBar"),
          backgroundColor: Colors.purple,
          expandedHeight: 150,
          elevation: 5,
        ),
        SliverList(
            delegate: SliverChildListDelegate(List.generate(
                30,
                (index) => ListTile(
                    tileColor: _getRandomColor(),
                    title: Text("Some name and idex: $index"))))),
        _createHeader('Header Section 1'),
        SliverGrid(
            delegate: SliverChildListDelegate(List.generate(
                99, (index) => Container(width: 25, color: _getRandomColor()))),
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
      ],
    );
  }

  Color _getRandomColor() =>
      Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);

  SliverPersistentHeader _createHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 60.0,
        maxHeight: 200.0,
        child: Container(
            color: Colors.lightBlue, child: Center(child: Text(headerText))),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
