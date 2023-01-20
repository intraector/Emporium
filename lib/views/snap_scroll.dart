import 'package:emporium/_constants/settings.dart';
import 'package:emporium/views/card_details/card_details.dart';
import 'package:emporium/views/card_details/components/white_page_route.dart';
import 'package:emporium/views/vivid_shadows/components/elastic_drag_alt.dart';
import 'package:emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:emporium/views/vivid_shadows/components/tappable_edges_with_shadows.dart';
import 'package:emporium/views/vivid_shadows/vivid_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll({
    required this.cell,
    this.isShadowsOn = false,
    this.isRotationOn = false,
    this.isElasticOn = false,
    this.initialPage = 0,
    this.onPageChanged,
    required this.index,
    this.maxRotation = 15.0,
  }) : pageController = PageController(initialPage: initialPage, viewportFraction: cell.widthRatio);
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool isElasticOn;
  final Cell cell;

  final int initialPage;
  final Function(int)? onPageChanged;
  final int index;
  final PageController pageController;
  final double maxRotation;

  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> with SingleTickerProviderStateMixin {
  Axis scrollDirection = Axis.horizontal;
  ScrollController listContoller = ScrollController();
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController? _tweenController;
  Tween<double>? _tween;
  Animation<double>? _tweenAnim;
  late double currentPageValue;
  late int focusedPage;
  final paths = {
    '0': 'assets/images/vertical.jpg',
    '3': 'assets/images/smoke.jpg',
    '7': 'assets/images/bananas.png',
  };
  @override
  void initState() {
    focusedPage = widget.initialPage;
    currentPageValue = widget.initialPage.toDouble();
    super.initState();
  }

  var effect = GetIt.I<Settings>().effect;

  @override
  Widget build(BuildContext context) {
    Widget pageView = PageView.builder(
        controller: widget.pageController,
        itemCount: widget.cell.cardsQty,
        scrollDirection: scrollDirection,
        onPageChanged: widget.onPageChanged,
        dragStartBehavior: DragStartBehavior.down,
        itemBuilder: (context, page) {
          // print('---------- {widget.cell.uids[page]} : ${widget.cell.uids[page]}');
          var count = (page / 3).toStringAsFixed(1).split('.').last;
          Widget child = VividCard(
            _normalizedOffset,
            uid: widget.cell.uids[page],
            axis: scrollDirection,
            shadowsIsOn: widget.isShadowsOn,
            path: paths[count]!,
            cardWidth: widget.cell.width - (widget.cell.width * widget.cell.paddingRatioH),
            cardHeight: widget.cell.height - (widget.cell.height * widget.cell.paddingRatioV),
          );

          return ElasticDragAlt(
            isOn: (widget.isElasticOn && focusedPage == page),
            axis: Axis.horizontal,
            distance: 30.0,
            offset: _normalizedOffset,
            width: widget.cell.width,
            height: widget.cell.height,
            child: Container(
              alignment: Alignment.center,
              transform: getTransfromation(effect, currentPageValue - page),
              child: Rotation3d(
                rotationIsOn: widget.isRotationOn,
                rotationX: scrollDirection == Axis.vertical ? _normalizedOffset * widget.maxRotation : 0,
                rotationY: scrollDirection == Axis.horizontal ? -_normalizedOffset * widget.maxRotation : 0,
                child: widget.isShadowsOn
                    ? TappableEdgesWithShadows(
                        child: child,
                        width: widget.cell.width,
                        height: widget.cell.height,
                        margin: EdgeInsets.symmetric(
                            horizontal: widget.cell.width * widget.cell.paddingRatioH,
                            vertical: widget.cell.height * widget.cell.paddingRatioV),
                      )
                    : TappableEdges(
                        child: child,
                        width: widget.cell.width,
                        height: widget.cell.height,
                        margin: EdgeInsets.symmetric(
                            horizontal: widget.cell.width * widget.cell.paddingRatioH,
                            vertical: widget.cell.height * widget.cell.paddingRatioV),
                        onTap: () {
                          Navigator.push(
                              context,
                              WhitePageRoute(
                                  enterPage: CardDetails(
                                path: paths[count]!,
                                uid: widget.cell.uids[page],
                                screenSize: MediaQuery.of(context).size,
                              )));

                          // Navigator.of(context).push(MaterialPageRoute(
                          // builder: (context) => CardDetails(
                          //       path: paths[count],
                          //       uid: widget.cell.uids[page],
                          //     ))
                          // );
                        },
                      ),
              ),
            ),
          );
        });
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: Column(children: [Flexible(child: pageView)]),
      ),
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      currentPageValue = widget.pageController.page!;
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      _tweenController?.stop();
    } else if (notification is ScrollEndNotification) {
      focusedPage = widget.pageController.page!.round();
    }
    return true;
  }

  void _handlePointerUp(PointerUpEvent event) {
    if (_isScrolling) {
      _isScrolling = false;
      _startOffsetTweenToZero();
    }
  }

  void _setOffset(double value) {
    setState(() {
      _normalizedOffset = value;
    });
  }

  void _startOffsetTweenToZero() {
    int tweenTime = 1000;
    if (_tweenController == null) {
      _tweenController = AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim = _tween?.animate(CurvedAnimation(parent: _tweenController!, curve: Curves.elasticOut))
        ?..addListener(() {
          _setOffset(_tweenAnim!.value);
        });
    }
    _tween!.begin = _normalizedOffset;
    _tweenController?.reset();
    _tween!.end = 0;
    _tweenController!.forward();
  }

  @override
  void dispose() {
    _tweenController?.dispose();
    super.dispose();
  }
}

Matrix4? getTransfromation(Effect effect, double value) {
  Matrix4? output;
  switch (effect) {
    case Effect.none:
      return output = null;
    case Effect.first:
      output = Matrix4.identity()..rotateX(value);
      break;
    case Effect.second:
      output = Matrix4.identity()
        ..rotateY(value)
        ..rotateZ(value);
      break;
    case Effect.third:
      output = Matrix4.identity()
        ..setEntry(3, 2, 0.004)
        ..rotateY(value)
        ..rotateZ(value);
      break;
    case Effect.forth:
      output = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(value)
        ..rotateY(value)
        ..rotateZ(value);
      break;
  }

  return output;
}
