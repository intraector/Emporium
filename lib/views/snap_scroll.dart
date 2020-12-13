import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/views/vivid_shadows/components/elastic_drag_alt.dart';
import 'package:Emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges_with_shadows.dart';
import 'package:Emporium/views/vivid_shadows/vivid_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll({
    @required this.cardWidth,
    @required this.cardHeight,
    this.isShadowsOn,
    this.isRotationOn,
    this.isElasticOn,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
    this.onPageChanged,
    this.index,
    this.maxRotation = 15.0,
    this.verticalPaddingRatio = 0.02,
    this.horizontalPaddingRatio = 0.02,
  }) : pageController =
            PageController(initialPage: initialPage, viewportFraction: viewportFraction);
  final double cardWidth;
  final double cardHeight;
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool isElasticOn;
  final double viewportFraction;
  final int initialPage;
  final Function(int) onPageChanged;
  final int index;
  final PageController pageController;
  final double maxRotation;
  final double verticalPaddingRatio;
  final double horizontalPaddingRatio;

  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> with SingleTickerProviderStateMixin {
  Axis scrollDirection = Axis.horizontal;
  ScrollController listContoller = ScrollController();
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;

  AnimationController _tweenController;
  Tween<double> _tween;
  Animation<double> _tweenAnim;
  double currentPageValue;
  int focusedPage;
  final paths = {
    '0': 'assets/images/vertical.jpg',
    '3': 'assets/images/smoke.jpg',
    '7': 'assets/images/bananas.png',
  };
  int cardQty = GetIt.I<Settings>().cardsQty;
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
        itemCount: cardQty,
        scrollDirection: scrollDirection,
        onPageChanged: widget.onPageChanged,
        dragStartBehavior: DragStartBehavior.down,
        itemBuilder: (context, page) {
          var count = (page / 3).toStringAsFixed(1).split('.').last;
          Widget child = VividCard(
            _normalizedOffset,
            axis: scrollDirection,
            shadowsIsOn: widget.isShadowsOn,
            path: paths[count],
            cardWidth: widget.cardWidth - (widget.cardWidth * widget.horizontalPaddingRatio),
            cardHeight: widget.cardHeight - (widget.cardHeight * widget.verticalPaddingRatio),
          );

          return ElasticDragAlt(
            isOn: (widget.isElasticOn && focusedPage == page),
            axis: Axis.horizontal,
            distance: 15.0,
            offset: _normalizedOffset,
            width: widget.cardWidth,
            height: widget.cardHeight,
            child: Container(
              alignment: Alignment.center,
              transform: getTransfromation(effect, currentPageValue - page),
              child: Rotation3d(
                rotationIsOn: widget.isRotationOn,
                rotationX:
                    scrollDirection == Axis.vertical ? _normalizedOffset * widget.maxRotation : 0,
                rotationY: scrollDirection == Axis.horizontal
                    ? -_normalizedOffset * widget.maxRotation
                    : 0,
                child: widget.isShadowsOn
                    ? TappableEdgesWithShadows(
                        child: child,
                        width: widget.cardWidth,
                        height: widget.cardHeight,
                        margin: EdgeInsets.symmetric(
                            horizontal: widget.cardWidth * widget.horizontalPaddingRatio,
                            vertical: widget.cardHeight * widget.verticalPaddingRatio),
                      )
                    : TappableEdges(
                        child: child,
                        width: widget.cardWidth,
                        height: widget.cardHeight,
                        margin: EdgeInsets.symmetric(
                            horizontal: widget.cardWidth * widget.horizontalPaddingRatio,
                            vertical: widget.cardHeight * widget.verticalPaddingRatio),
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
      currentPageValue = widget.pageController.page;
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
      if (_tween != null) {
        _tweenController.stop();
      }
    } else if (notification is ScrollEndNotification) {
      focusedPage = widget.pageController.page.round();
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
      _tweenController =
          AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      _tween = Tween<double>(begin: -1, end: 0);
      _tweenAnim =
          _tween.animate(CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut))
            ..addListener(() {
              _setOffset(_tweenAnim.value);
            });
    }
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }

  @override
  void dispose() {
    _tweenController?.dispose();
    super.dispose();
  }
}

Matrix4 getTransfromation(Effect effect, double value) {
  Matrix4 output;
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
