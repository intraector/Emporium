import 'package:Emporium/_constants/settings.dart';
import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final Cells cells;

  CustomScrollPhysics({this.cells, ScrollPhysics parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(cells: cells, parent: buildParent(ancestor));
  }

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    var page = cells.getPage(position.pixels);
    var pixels = position.pixels;
    if (velocity < -tolerance.velocity) {
      pixels = page.key;
    } else if (velocity > tolerance.velocity) {
      pixels = page.key + page.value;
    }
    return pixels;
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
      return super.createBallisticSimulation(position, velocity);
    final Tolerance tolerance = this.tolerance;
    final double target = _getTargetPixels(position, tolerance, velocity * 40000);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, velocity,
          tolerance: tolerance);
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
