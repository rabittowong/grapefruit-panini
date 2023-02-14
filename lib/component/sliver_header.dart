import 'package:flutter/material.dart';

import 'sliver_header_painter.dart';

class SliverHeader extends SliverPersistentHeaderDelegate {
  const SliverHeader({
    required this.title,
    this.height = 70,
  });

  final String title;
  final double height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width,
            height: height,
            child: const CustomPaint(
              painter: SliverHeaderPainter(lineColor: Colors.deepOrange),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
