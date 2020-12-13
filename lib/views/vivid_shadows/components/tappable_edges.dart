import 'package:Emporium/common_components/multi_gesture_detector.dart';
import 'package:Emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class TappableEdges extends StatefulWidget {
  TappableEdges(
      {@required this.child, @required this.width, @required this.height, @required this.margin});
  final Widget child;
  final double width;
  final double height;
  final EdgeInsetsGeometry margin;

  @override
  _TappableEdgesState createState() => _TappableEdgesState();
}

class _TappableEdgesState extends State<TappableEdges> with TickerProviderStateMixin {
  final initialOffset = Offset(3.0, 3.0);
  final double xShift = 1.0;
  final double vShift = 1.0;

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

  @override
  void dispose() {
    hController.dispose();
    vController.dispose();
    super.dispose();
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
