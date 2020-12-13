import 'package:Emporium/_constants/settings.dart';
import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final Cells cells;

  CustomScrollPhysics({this.cells, ScrollPhysics parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics ancestor) {
    return CustomScrollPhysics(cells: cells, parent: buildParent(ancestor));
  }

  // double _getPage(ScrollPosition position) => position.pixels / cells.itemExtent(position.pixels);

  // double _getPixels(double page) => page * cells.itemExtent;

  double _getTargetPixels(ScrollPosition position, Tolerance tolerance, double velocity) {
    // double page = _getPage(position);
    var page = cells.getPage(position.pixels);
    print('PAGE: ${page}');
    var pixels = position.pixels;
    if (velocity < -tolerance.velocity) {
      // page -= 0.5;
      pixels = page.key;
    } else if (velocity > tolerance.velocity) {
      // page += 0.5;
      pixels = page.key + page.value;
    }
    return pixels;
    // return _getPixels(page.roundToDouble());
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
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
