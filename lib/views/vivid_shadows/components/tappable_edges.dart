import 'package:emporium/common_components/multi_gesture_detector.dart';
import 'package:emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TappableEdges extends StatefulWidget {
  TappableEdges({
    required this.child,
    required this.width,
    required this.height,
    required this.margin,
    this.onTap,
  });
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;
  final Function()? onTap;

  @override
  _TappableEdgesState createState() => _TappableEdgesState();
}

class _TappableEdgesState extends State<TappableEdges> with TickerProviderStateMixin {
  final initialOffset = Offset(3.0, 3.0);
  final double xShift = 1.0;
  final double vShift = 1.0;

  late AnimationController hController;
  late Animation<double> hAnimation;

  late AnimationController vController;
  late Animation<double> vAnimation;

  bool hasMoved = false;

  @override
  void initState() {
    super.initState();

    hController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 100),
    );
    hAnimation = Tween<double>(begin: xShift, end: -xShift).animate(hController);

    vController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 100),
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
            builder: (context, child) => Rotation3d(
              rotationX: -vAnimation.value * 5,
              rotationY: hAnimation.value * 5,
              child: Container(
                margin: widget.margin,
                child: widget.child,
              ),
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
              onMove: (event) {
                if (event.localDelta.distance != 0.0) hasMoved = true;
                // print('---------- onMove has moved: $hasMoved | event.distance: ${event.delta.distance}');
              },
              onDown: (event) {
                final RenderBox? referenceBox = context.findRenderObject() as RenderBox?;
                var localPosition = referenceBox?.globalToLocal(event.position);
                bool isOnEdge = false;

                if (localPosition?.isInLeftArea(constraints: constraints) ?? false) {
                  isOnEdge = true;
                  hController.animateTo(0.0);
                }
                if (localPosition?.isInRightArea(constraints: constraints) ?? false) {
                  isOnEdge = true;
                  hController.animateTo(1.0);
                }
                if (localPosition?.isInTopArea(constraints: constraints) ?? false) {
                  isOnEdge = true;
                  vController.animateTo(0.0);
                }
                if (localPosition?.isInBottomArea(constraints: constraints) ?? false) {
                  isOnEdge = true;
                  vController.animateTo(1.0);
                }
                if (!isOnEdge) {
                  print('---------- center');
                  // widget.onTap();
                } else {
                  print('---------- on edge');
                }
              },
              onUp: (event) {
                print('---------- onUp has moved: $hasMoved');
                hController.animateTo(0.5);
                vController.animateTo(0.5);
                if (!hasMoved) widget.onTap?.call();
                hasMoved = false;
              },
            );
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    hController.dispose();
    vController.dispose();
    super.dispose();
  }
}

extension IsInLeftArea on Offset {
  bool isInLeftArea({
    required BoxConstraints constraints,
    double areaWidth = kMinInteractiveDimension,
  }) {
    return (this.dx >= 0 && this.dx <= areaWidth && this.dy >= 0 && this.dy <= constraints.minHeight);
  }
}

extension IsInRightArea on Offset {
  bool isInRightArea({
    required BoxConstraints constraints,
    double areaWidth = kMinInteractiveDimension,
  }) {
    return (this.dx >= (constraints.minWidth - areaWidth) &&
        this.dx <= constraints.minWidth &&
        this.dy >= 0 &&
        this.dy <= constraints.minHeight);
  }
}

extension IsInTopArea on Offset {
  bool isInTopArea({
    required BoxConstraints constraints,
    double areaWidth = kMinInteractiveDimension,
  }) {
    return (this.dx >= 0 && this.dx <= constraints.minWidth && this.dy >= 0 && this.dy <= areaWidth);
  }
}

extension IsInBottomArea on Offset {
  bool isInBottomArea({
    required BoxConstraints constraints,
    double areaWidth = kMinInteractiveDimension,
  }) {
    return (this.dx >= 0 &&
        this.dx <= constraints.minWidth &&
        this.dy >= (constraints.minHeight - areaWidth) &&
        this.dy <= constraints.minHeight);
  }
}
