import 'dart:math';

import 'package:flutter/material.dart';

class Rotation3d extends StatelessWidget {
  const Rotation3d({
    super.key,
    required this.child,
    this.rotationX = 0,
    this.rotationY = 0,
    this.rotationZ = 0,
    this.rotationIsOn = true,
  });

  static const double degrees2Radians = pi / 180;

  final Widget child;
  final bool rotationIsOn;
  final double rotationX;
  final double rotationY;
  final double rotationZ;

  @override
  Widget build(BuildContext context) {
    Matrix4 transform = Matrix4.identity()..setEntry(3, 2, 0.001);
    if (rotationIsOn) {
      transform
        ..rotateX(rotationX * degrees2Radians)
        ..rotateY(rotationY * degrees2Radians)
        ..rotateZ(rotationZ * degrees2Radians);
    }
    return Transform(alignment: FractionalOffset.center, transform: transform, child: child);
  }
}
