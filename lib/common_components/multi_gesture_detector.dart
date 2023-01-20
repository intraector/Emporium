import 'package:emporium/common_components/multi_gesture_recognizer.dart';
import 'package:flutter/material.dart';

class MultiGestureDetector extends StatelessWidget {
  MultiGestureDetector({
    required this.child,
    this.onMove,
    this.onUp,
    this.onDown,
  });
  final Widget child;
  final Function(PointerMoveEvent)? onMove;
  final Function(PointerUpEvent)? onUp;
  final Function(PointerDownEvent)? onDown;
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        MultiGestureRecognizer: GestureRecognizerFactoryWithHandlers<MultiGestureRecognizer>(
          () => MultiGestureRecognizer(onUp: onUp, onMove: onMove, onDown: onDown),
          (instance) {},
        ),
      },
      child: child,
    );
  }
}
