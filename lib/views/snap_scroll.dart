import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/views/vivid_shadows/components/elastic_drag.dart';
import 'package:Emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges_with_shadows.dart';
import 'package:Emporium/views/vivid_shadows/vivid_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll({
    @required this.cardWidth,
    @required this.cardHeight,
    this.isShadowsOn,
    this.isRotationOn,
    this.elasticIsOn,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
    this.onPageChanged,
  });
  final double cardWidth;
  final double cardHeight;
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool elasticIsOn;
  final double viewportFraction;
  final int initialPage;
  final Function(int) onPageChanged;
  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> with SingleTickerProviderStateMixin {
  Axis scrollDirection = Axis.horizontal;
  List<int> data = [];
  PageController _pageController;
  ScrollController listContoller = ScrollController();
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;
  final double _maxRotation = 15;
  double cardMarginTop = 20.0;
  double cardMarginBottom = 20.0;
  AnimationController _tweenController;
  Tween<double> _tween;
  Animation<double> _tweenAnim;
  double currentPage;
  final paths = {
    '0': 'assets/images/vertical.jpg',
    '3': 'assets/images/smoke.jpg',
    '7': 'assets/images/bananas.png',
  };
  int cardQty = GetIt.I<Settings>().cardsQty;

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
      initialPage: widget.initialPage, viewportFraction: widget.viewportFraction,
      // viewportFraction: widget.cardHeight / MediaQuery.of(context).size.height,
    );
    Widget listContent = PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: cardQty,
        scrollDirection: scrollDirection,
        onPageChanged: widget.onPageChanged,
        itemBuilder: (context, index) {
          double marginVertical = widget.cardHeight * 0.02;
          double marginHorizontal = widget.cardWidth * 0.05;
          var count = (index / 3).toStringAsFixed(1).split('.').last;
          Widget child = VividCard(
            _normalizedOffset,
            axis: scrollDirection,
            shadowsIsOn: widget.isShadowsOn,
            path: paths[count],
            cardWidth: widget.cardWidth - marginVertical * 2,
            cardHeight: widget.cardHeight - marginHorizontal * 2,
          );
          return Center(
            child: ElasticDrag(
              itemIndex: index,
              currentPage: currentPage,
              offset: _normalizedOffset,
              isOn: widget.elasticIsOn,
              margin: 5.0,
              elasticMargin: scrollDirection == Axis.vertical
                  ? widget.cardHeight * 0.2
                  : widget.cardWidth * 0.1,
              axis: scrollDirection,
              child: Container(
                // color: Colors.pink.withOpacity(0.3),
                child: Rotation3d(
                  rotationIsOn: widget.isRotationOn,
                  rotationX:
                      scrollDirection == Axis.vertical ? _normalizedOffset * _maxRotation : 0,
                  rotationY:
                      scrollDirection == Axis.horizontal ? -_normalizedOffset * _maxRotation : 0,
                  child: widget.isShadowsOn
                      ? TappableEdgesWithShadows(
                          child: child,
                          width: widget.cardWidth,
                          height: widget.cardHeight,
                          margin: EdgeInsets.symmetric(
                              horizontal: marginHorizontal, vertical: marginVertical),
                        )
                      : Container(
                          // color: Colors.pink.withOpacity(0.3),
                          child: TappableEdges(
                            child: child,
                            width: widget.cardWidth,
                            height: widget.cardHeight,
                            margin: EdgeInsets.symmetric(
                                horizontal: marginHorizontal, vertical: marginVertical),
                          ),
                        ),
                ),
              ),
            ),
          );
        });
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: Column(children: [Flexible(child: listContent)]),
      ),
    );
  }

  bool _handleScrollNotifications(Notification notification) {
    if (notification is ScrollUpdateNotification) {
      currentPage = _pageController.page;
      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
      //_focusedIndex = (_prevScrollX / (_itemWidth + _listItemPadding)).round();
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
      _prevScrollX = notification.metrics.pixels;
      if (_tween != null) {
        _tweenController.stop();
      }
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
          _tween.animate(new CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut))
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
