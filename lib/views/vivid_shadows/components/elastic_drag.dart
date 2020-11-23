import 'package:emporium/common_components/multi_gesture_detector.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ElasticDrag extends StatefulWidget {
  ElasticDrag({@required this.child});
  final Widget child;

  @override
  _ElasticDragState createState() => _ElasticDragState();
}

class _ElasticDragState extends State<ElasticDrag> with SingleTickerProviderStateMixin {
  AnimationController vController;
  Animation<double> vAnimation;

  @override
  void initState() {
    GestureBinding.instance.resamplingEnabled = true;
    super.initState();
    vController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 100),
    );
    vAnimation = Tween<double>(begin: -defaultPadding, end: defaultPadding).animate(vController);
  }

  double lastY;
  double defaultPadding = 20.0;
  double bottomPadding = 20.0;
  double topPadding = 20.0;
  TickerFuture isAnimationRunning;

  @override
  Widget build(BuildContext context) {
    return MultiGestureDetector(
      child: AnimatedBuilder(
        animation: vAnimation,
        builder: (context, child) => Padding(
          padding: EdgeInsets.only(
              top: defaultPadding + vAnimation.value, bottom: bottomPadding - vAnimation.value),
          child: widget.child,
        ),
      ),
      onDown: (event) {
        lastY = event.position.dy;
// if(isAnimationRunning. )
        vController.stop();
        // vController.animateTo(1.0);
      },
      onMove: (event) {
        var distance = event.position.dy - lastY;
        if (distance.isNegative) {
          if (distance.abs() <= (defaultPadding)) {
            // setState(() {
            //   bottomPadding = defaultPadding + distance.abs();
            //   topPadding = ((defaultPadding - distance.abs())).clamp(0.0, defaultPadding);
            // });
            var tt = distance.abs() / defaultPadding;
            isAnimationRunning = vController.animateTo(0.5 - (0.5 * tt));
          }
        }
        if (!distance.isNegative) {
          if (distance.abs() <= (defaultPadding)) {
            // setState(() {
            //   topPadding = defaultPadding + distance.abs();
            //   bottomPadding = ((defaultPadding - distance.abs())).clamp(0.0, defaultPadding);
            //   print('DISTANCE.ABS(): ${distance.abs()}');
            //   print('BOTTOMPADDING: ${bottomPadding}');
            // });
            var tt = distance.abs() / defaultPadding;
            isAnimationRunning = vController.animateTo(0.5 + (0.5 * tt));
          }
        }
      },
      onUp: (_) {
        // setState(() {
        //   topPadding = defaultPadding;
        //   bottomPadding = defaultPadding;
        // });
        vController.animateTo(0.5);
      },
    );
  }

  @override
  void dispose() {
    vController.dispose();
    super.dispose();
  }
}
