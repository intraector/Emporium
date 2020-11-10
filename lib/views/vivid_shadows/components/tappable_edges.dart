import 'package:emporium/common_components/multi_gesture_detector.dart';
import 'package:emporium/views/vivid_shadows/components/item.dart';
import 'package:flutter/material.dart';

class TappableEdges extends StatefulWidget {
  TappableEdges({@required this.screenWidth, @required this.path});
  final double screenWidth;
  final String path;

  @override
  _TappableEdgesState createState() => _TappableEdgesState();
}

class _TappableEdgesState extends State<TappableEdges> with TickerProviderStateMixin {
  final double ratio = 1.479;

  AnimationController hController;
  Animation<double> hAnim;

  AnimationController vController;
  Animation<double> vAnim;

  @override
  void initState() {
    super.initState();

    hController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 10),
    );
    hAnim = Tween<double>(begin: 5, end: -5).animate(hController);

    vController = AnimationController(
      vsync: this,
      value: 0.5,
      duration: Duration(milliseconds: 10),
    );
    vAnim = Tween<double>(begin: 5, end: -5).animate(vController);
  }

  @override
  Widget build(BuildContext context) {
    final double padding = kMinInteractiveDimension / 2;

    var _color = Colors.white.withOpacity(0.2);
    return Stack(
      children: [
        AnimatedBuilder(
          animation: vAnim,
          builder: (context, child) => AnimatedBuilder(
            animation: hAnim,
            builder: (context, child) => Container(
              margin: EdgeInsets.symmetric(horizontal: padding, vertical: padding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                    offset: Offset(hAnim.value + 5, vAnim.value + 5),
                  ),
                ],
              ),
              child: Item(screenWidth: widget.screenWidth, path: widget.path),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: LayoutBuilder(builder: (context, constraints) {
            print('---------- constraints : $constraints');
            return MultiGestureDetector(
              child: Container(
                color: _color,
                // width: thickness,
                // height: widget.screenWidth * ratio + paddingV * 2,
              ),
              onDown: (event) {
                print(event.localPosition);

                // if (event.position) hController.animateTo(1.0);
              },
              onUp: (event) {
                hController.animateTo(0.5);
              },
            );
          }),
        ),
      ],
    );
  }
}
