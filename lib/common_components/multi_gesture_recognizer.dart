import 'package:flutter/gestures.dart';

class MultiGestureRecognizer extends OneSequenceGestureRecognizer {
  MultiGestureRecognizer({
    this.onMove,
    this.onUp,
    this.onDown,
  });

  final Function(PointerMoveEvent)? onMove;
  final Function(PointerUpEvent)? onUp;
  final Function(PointerDownEvent)? onDown;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
    // resolve(GestureDisposition.accepted);
  }

  @override
  String get debugDescription => 'singlePointerDrag';

  @override
  void didStopTrackingLastPointer(int pointer) {
    stopTrackingPointer(pointer);
  }

  // double lastY;
  @override
  void handleEvent(PointerEvent event) {
    if (event is PointerDownEvent) {
      onDown?.call(event);
    } else if (event is PointerMoveEvent) {
      onMove?.call(event);
    } else if (event is PointerUpEvent) {
      onUp?.call(event);
      stopTrackingPointer(event.pointer);
    }
  }
}
