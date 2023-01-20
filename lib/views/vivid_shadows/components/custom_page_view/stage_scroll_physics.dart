// ignore_for_file: must_be_immutable

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class StageScrollingPhysics extends ScrollPhysics {
  StageScrollingPhysics({
    super.parent,
    required this.stages,
    this.currentStage = 0,
  });

  /// Creates scroll physics that prevent the scroll offset from exceeding the
  /// bounds of the content..
  ///
  int currentStage;

  final List<double> stages;

  @override
  bool get allowImplicitScrolling => false;

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return StageScrollingPhysics(parent: buildParent(ancestor), stages: this.stages, currentStage: this.currentStage);
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (position.outOfRange) {
      late double end;
      if (position.pixels > position.maxScrollExtent) end = position.maxScrollExtent;
      if (position.pixels < position.minScrollExtent) end = position.minScrollExtent;
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        end,
        math.min(0.0, velocity),
        tolerance: tolerance,
      );
    }
    final double target = _getTargetPixels(position, tolerance, velocity);
    if (target != position.pixels)
      return ScrollSpringSimulation(spring, position.pixels, target, position.pixels > target ? -200 : 200,
          tolerance: tolerance);
    return null;
  }

  double _getPixels() {
    return stages[currentStage];
  }

  double _getTargetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    if (velocity < -tolerance.velocity) {
      if (currentStage - 1 >= 0) currentStage--;
    } else if (velocity > tolerance.velocity) {
      if (currentStage + 1 < this.stages.length) currentStage++;
    }
    return _getPixels();
  }
}
