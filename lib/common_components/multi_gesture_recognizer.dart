import 'package:flutter/gestures.dart';

class MultiGestureRecognizer extends OneSequenceGestureRecognizer {
  final Function(PointerMoveEvent) onMove;
  final Function(PointerUpEvent) onUp;
  final Function(PointerDownEvent) onDown;

  MultiGestureRecognizer({
    this.onMove,
    this.onUp,
    this.onDown,
  });

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    // resolve(GestureDisposition.accepted);
  }

  // double lastY;
  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      if (onDown != null) onDown(event);
    } else if (event is PointerMoveEvent) {
      if (onMove != null) onMove(event);
    } else if (event is PointerUpEvent) {
      if (onUp != null) onUp(event);
      stopTrackingPointer(event.pointer);
    }
  }

  @override
  String get debugDescription => 'singlePointerDrag';

  @override
  void didStopTrackingLastPointer(int pointer) {
    stopTrackingPointer(pointer);
  }
}
