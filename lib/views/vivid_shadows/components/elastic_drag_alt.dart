import 'package:flutter/material.dart';

class ElasticDragAlt extends StatelessWidget {
  ElasticDragAlt({
    required this.offset,
    required this.child,
    this.isOn = true,
    required this.distance,
    this.axis = Axis.vertical,
    required this.width,
    required this.height,
  });

  final double offset;
  final bool isOn;
  final double distance;
  final Axis axis;
  final double width;
  final double height;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    double left = 0;
    double right = 0;
    if (isOn) {
      switch (axis) {
        case Axis.vertical:
        case Axis.horizontal:
          {
            var output = offset.abs() * distance;
            if (offset.isNegative) {
              left = output;
              right = -output;
            } else {
              left = -output;
              right = output;
            }
            break;
          }
      }
    }
    // print('---------- offset : $offset');
    // print('---------- top : $top');
    // print('---------- left : $left');
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 0,
            left: left,
            right: right,
            bottom: 0,
            child: SizedBox(
              width: width,
              height: height,
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
