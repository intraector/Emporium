import 'package:Emporium/views/vivid_shadows/components/elastic_drag.dart';
import 'package:Emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:Emporium/views/vivid_shadows/components/tappable_edges_with_shadows.dart';
import 'package:Emporium/views/vivid_shadows/components/vivid_card.dart';
import 'package:flutter/material.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll({this.screenWidth, this.shadowsIsOn, this.rotationIsOn, this.elasticIsOn})
      : cardHeight = screenWidth * 1.479;
  final double screenWidth;
  final double cardHeight;
  final bool shadowsIsOn;
  final bool rotationIsOn;
  final bool elasticIsOn;
  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(
        initialPage: 1,
        viewportFraction: (widget.cardHeight + 30) / MediaQuery.of(context).size.height);
    Widget listContent = PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: 8,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          double margin = 20.0;
          var count = (index / 3).toStringAsFixed(1).split('.').last;
          Widget child = VividCard(
            _normalizedOffset,
            shadowsIsOn: widget.shadowsIsOn,
            path: paths[count],
            cardWidth: widget.screenWidth - margin * 2,
            cardHeight: widget.cardHeight,
          );
          return ElasticDrag(
            itemIndex: index,
            currentPage: currentPage,
            offset: _normalizedOffset,
            isOn: widget.elasticIsOn,
            margin: 5.0,
            elasticMargin: 20.0,
            child: Rotation3d(
              rotationX: widget.rotationIsOn ? (_normalizedOffset * _maxRotation) : 0,
              child: widget.shadowsIsOn
                  ? TappableEdgesWithShadows(
                      child: child,
                      width: widget.screenWidth,
                      height: widget.cardHeight,
                      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 5.0),
                    )
                  : TappableEdges(
                      child: child,
                      width: widget.screenWidth,
                      height: widget.cardHeight,
                      margin: EdgeInsets.symmetric(horizontal: margin, vertical: 5.0),
                    ),
            ),
          );
        });
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: Column(
          children: [
            Expanded(child: listContent),
          ],
        ),
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
}
