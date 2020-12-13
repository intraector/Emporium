import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomSimulation extends Simulation {
  CustomSimulation({this.initPosition, this.velocity});
  final double initPosition;
  final double velocity;
  @override
  double dx(double time) {
    var max = math.max(math.min(initPosition, 0.0), initPosition * velocity * time);
    return max;
  }

  @override
  double x(double time) {
    return velocity;
  }

  @override
  bool isDone(double time) {
    return false;
  }
}
