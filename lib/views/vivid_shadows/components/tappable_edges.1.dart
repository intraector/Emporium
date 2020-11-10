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
    final double paddingH = 24.0;
    final double paddingV = 24.0;
    var thickness = 40.0;
    var _color = Colors.white.withOpacity(0.2);
    return Stack(
      children: [
        AnimatedBuilder(
          animation: vAnim,
          builder: (context, child) => AnimatedBuilder(
            animation: hAnim,
            builder: (context, child) => Container(
              margin: EdgeInsets.symmetric(horizontal: paddingH, vertical: paddingV),
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
          left: (thickness - paddingH) / 2,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: _color,
              width: thickness,
              height: widget.screenWidth * ratio + paddingV * 2,
            ),
            onTapDown: (_) {
              print('---------- onTapDown');
              hController.animateTo(0.0);
            },
            onTapCancel: () {
              hController.animateTo(0.5);
              print('---------- onTapCancel');
            },
            onTapUp: (_) {
              hController.animateTo(0.5);
              print('---------- onTapUp');
            },
            onPanDown: (_) {
              hController.animateTo(0.0);
              print('---------- onPanDown');
            },
            onPanEnd: (_) {
              hController.animateTo(0.5);
              print('---------- onPanEnd');
            },
            onPanCancel: () {
              print('---------- onPanCancel');
              hController.animateTo(0.5);
            },
            onPanStart: (_) {
              print('---------- onPanStart');
              hController.animateTo(0.0);
            },
            onPanUpdate: (_) {
              print('---------- onPanUpdate');
              hController.animateTo(0.0);
            },
            onVerticalDragStart: (_) {
              hController.animateTo(0.0);
              print('---------- onVerticalDragStart');
            },
            onVerticalDragEnd: (_) => hController.animateTo(0.5),
            onVerticalDragCancel: () => hController.animateTo(0.5),
            onHorizontalDragCancel: () => print('---------- onHorizontalDragCancel'),
          ),
        ),
        Positioned(
          right: (thickness - paddingH) / 2,
          child: MultiGestureDetector(
            child: Container(
              color: _color,
              width: thickness,
              height: widget.screenWidth * ratio + paddingV * 2,
            ),
            onDown: (event) {
              print(event.position);
              hController.animateTo(1.0);
            },
            onUp: (event) {
              hController.animateTo(0.5);
            },
          ),
        ),
        Positioned(
          top: (paddingV - thickness) / 2,
          left: (thickness - paddingH) / 2,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: _color,
              width: widget.screenWidth - thickness / 2,
              height: thickness,
            ),
            onPanDown: (_) => vController.animateTo(0.0),
            onHorizontalDragEnd: (_) => vController.animateTo(0.5),
            onHorizontalDragCancel: () => vController.animateTo(0.5),
          ),
        ),
        Positioned(
          bottom: (paddingV - thickness) / 2,
          left: (thickness - paddingH) / 2,
          child: MultiGestureDetector(
            child: Container(
              color: _color,
              width: widget.screenWidth - thickness / 2,
              height: thickness,
            ),
            onDown: (_) => vController.animateTo(1.0),
            onUp: (_) => vController.animateTo(0.5),
          ),
        ),
      ],
    );
  }
}
