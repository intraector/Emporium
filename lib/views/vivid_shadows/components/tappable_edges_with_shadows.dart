import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../common_components/multi_gesture_detector.dart';
import 'rotation_3d.dart';

class TappableEdgesWithShadows extends StatefulWidget {
  TappableEdgesWithShadows({
    required this.child,
    required this.width,
    required this.height,
    margin,
  }) : this.margin = margin ?? EdgeInsets.symmetric(horizontal: 20, vertical: 5.0);

  final Widget child;
  final double height;
  final EdgeInsetsGeometry margin;
  final double width;

  @override
  _TappableEdgesState createState() => _TappableEdgesState();
}

class _TappableEdgesState extends State<TappableEdgesWithShadows> with TickerProviderStateMixin {
  late Animation<double> hAnimation;
  late AnimationController hController;
  final initialOffset = Offset(3.0, 3.0);
  late Animation<double> vAnimation;
  late AnimationController vController;
  final double vShift = 1.0;
  final double xShift = 1.0;

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
                child: NeumorphicTheme(
                  themeMode: ThemeMode.light,
                  theme: NeumorphicThemeData(
                    lightSource: LightSource(hAnimation.value, vAnimation.value),
                  ),
                  child: Neumorphic(
                    child: widget.child,
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25)),
                      depth: 8,
                      color: Colors.grey,
                    ),
                  ),
                ),
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
                final RenderBox? referenceBox = context.findRenderObject() as RenderBox?;
                var localPosition = referenceBox?.globalToLocal(event.position);

                if (localPosition?.isInLeftArea(constraints: constraints) ?? false) {
                  hController.animateTo(0.0);
                }
                if (localPosition?.isInRightArea(constraints: constraints) ?? false) {
                  hController.animateTo(1.0);
                }
                if (localPosition?.isInTopArea(constraints: constraints) ?? false) {
                  vController.animateTo(0.0);
                }
                if (localPosition?.isInBottomArea(constraints: constraints) ?? false) {
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
