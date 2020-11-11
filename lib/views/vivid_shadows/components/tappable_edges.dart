import 'package:emporium/common_components/multi_gesture_detector.dart';
import 'package:emporium/views/vivid_shadows/components/item.dart';
import 'package:flutter/material.dart';

class TappableEdges extends StatefulWidget {
  TappableEdges({@required this.width, @required this.path});
  final double width;
  final String path;

  @override
  _TappableEdgesState createState() => _TappableEdgesState();
}

class _TappableEdgesState extends State<TappableEdges> with TickerProviderStateMixin {
  final double ratio = 1.479;
  final double padding = 20.0;
  final double blurRadius = 10.0;
  final double spreadRadius = 1.0;
  final initialOffset = Offset(3.0, 3.0);
  final double xShift = 5.0;
  final double vShift = 5.0;

  AnimationController hController;
  Animation<double> hAnimation;

  AnimationController vController;
  Animation<double> vAnimation;

  @override
  void initState() {
    super.initState();

    hController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 200),
    );
    hAnimation = Tween<double>(begin: xShift, end: -xShift).animate(hController);

    vController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 200),
    );
    vAnimation = Tween<double>(begin: vShift, end: -vShift).animate(vController);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: vAnimation,
          builder: (context, child) => AnimatedBuilder(
            animation: hAnimation,
            builder: (context, child) => Container(
              margin: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: blurRadius,
                    spreadRadius: spreadRadius,
                    offset: Offset(hAnimation.value, vAnimation.value) + initialOffset,
                  ),
                ],
              ),
              child: Item(screenWidth: widget.width, path: widget.path),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: LayoutBuilder(builder: (context, constraints) {
            return MultiGestureDetector(
              child: Container(
                  // color: Colors.pink,
                  ),
              onDown: (event) {
                final RenderBox referenceBox = context.findRenderObject();
                var localPosition = referenceBox.globalToLocal(event.position);
                if (localPosition.isInLeftArea(constraints: constraints)) {
                  hController.animateTo(0.0);
                }
                if (localPosition.isInRightArea(constraints: constraints)) {
                  hController.animateTo(1.0);
                }
                if (localPosition.isInTopArea(constraints: constraints)) {
                  vController.animateTo(0.0);
                }
                if (localPosition.isInBottomArea(constraints: constraints)) {
                  vController.animateTo(1.0);
                }
              },
              onUp: (event) {
                hController.animateTo(0.5);
                vController.animateTo(0.5);
              },
            );
          }),
        ),
      ],
    );
  }
}

extension IsInLeftArea on Offset {
  bool isInLeftArea(
      {@required BoxConstraints constraints, double areaWidth = kMinInteractiveDimension}) {
    return (this.dx >= 0 &&
        this.dx <= areaWidth &&
        this.dy >= 0 &&
        this.dy <= constraints.minHeight);
  }
}

extension IsInRightArea on Offset {
  bool isInRightArea(
      {@required BoxConstraints constraints, double areaWidth = kMinInteractiveDimension}) {
    return (this.dx >= (constraints.minWidth - areaWidth) &&
        this.dx <= constraints.minWidth &&
        this.dy >= 0 &&
        this.dy <= constraints.minHeight);
  }
}

extension IsInTopArea on Offset {
  bool isInTopArea(
      {@required BoxConstraints constraints, double areaWidth = kMinInteractiveDimension}) {
    return (this.dx >= 0 &&
        this.dx <= constraints.minWidth &&
        this.dy >= 0 &&
        this.dy <= areaWidth);
  }
}

extension IsInBottomArea on Offset {
  bool isInBottomArea(
      {@required BoxConstraints constraints, double areaWidth = kMinInteractiveDimension}) {
    return (this.dx >= 0 &&
        this.dx <= constraints.minWidth &&
        this.dy >= (constraints.minHeight - areaWidth) &&
        this.dy <= constraints.minHeight);
  }
}
