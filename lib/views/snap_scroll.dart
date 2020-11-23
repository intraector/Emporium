import 'package:emporium/views/vivid_shadows/components/rotation_3d.dart';
import 'package:emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:emporium/views/vivid_shadows/components/vivid_card.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class SnapScroll extends StatefulWidget {
  SnapScroll(this.screenWidth);
  final double screenWidth;
  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> with SingleTickerProviderStateMixin {
  List<int> data = [];
  PageController _pageController;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  ScrollController listContoller = ScrollController();
  double _cardHeight = 300 * 1.479;
  double _normalizedOffset = 0;
  double _prevScrollX = 0;
  bool _isScrolling = false;
  final double _maxRotation = 15;
  double cardWidth;
  double cardHeight;
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
        initialPage: 1, viewportFraction: (_cardHeight + 30) / MediaQuery.of(context).size.height);
    //Create our main list
    Widget listContent = PageView.builder(
        //Use bounce-style scroll physics, feels better with this demo
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: 8,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          var count = (index / 3).toStringAsFixed(1).split('.').last;
          return Item(
            path: paths[count],
            cardHeight: widget.screenWidth * 1.479,
            cardWidth: widget.screenWidth,
            itemIndex: index,
            currentPage: currentPage,
            offset: _normalizedOffset,
            maxRotation: _maxRotation,
          );
        });
    return Listener(
      onPointerUp: _handlePointerUp,
      child: NotificationListener(
        onNotification: _handleScrollNotifications,
        child: listContent,
      ),
    );
  }

  //Check the notifications bubbling up from the ListView, use them to update our currentOffset and isScrolling state
  bool _handleScrollNotifications(Notification notification) {
    //Scroll Update, add to our current offset, but clamp to -1 and 1
    if (notification is ScrollUpdateNotification) {
      currentPage = _pageController.page;

      if (_isScrolling) {
        double dx = notification.metrics.pixels - _prevScrollX;
        double scrollFactor = .01;
        double newOffset = (_normalizedOffset + dx * scrollFactor);
        _setOffset(newOffset.clamp(-1.0, 1.0));
      }
      _prevScrollX = notification.metrics.pixels;
      //Calculate the index closest to middle
      //_focusedIndex = (_prevScrollX / (_itemWidth + _listItemPadding)).round();
    }
    //Scroll Start
    else if (notification is ScrollStartNotification) {
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

  //Tweens our offset from the current value, to 0
  void _startOffsetTweenToZero() {
    //The first time this runs, setup our controller, tween and animation. All 3 are required to control an active animation.
    int tweenTime = 1000;
    if (_tweenController == null) {
      //Create Controller, which starts/stops the tween, and rebuilds this widget while it's running
      _tweenController =
          AnimationController(vsync: this, duration: Duration(milliseconds: tweenTime));
      //Create Tween, which defines our begin + end values
      _tween = Tween<double>(begin: -1, end: 0);
      //Create Animation, which allows us to access the current tween value and the onUpdate() callback.
      _tweenAnim =
          _tween.animate(new CurvedAnimation(parent: _tweenController, curve: Curves.elasticOut))
            //Set our offset each time the tween fires, triggering a rebuild
            ..addListener(() {
              _setOffset(_tweenAnim.value);
            });
    }
    //Restart the tweenController and inject a new start value into the tween
    _tween.begin = _normalizedOffset;
    _tweenController.reset();
    _tween.end = 0;
    _tweenController.forward();
  }
}

class Item extends StatelessWidget {
  Item({
    this.currentPage,
    this.itemIndex,
    this.offset,
    this.cardWidth,
    this.cardHeight,
    this.maxRotation,
    @required this.path,
  });
  final double cardWidth;
  final double cardHeight;
  final double currentPage;
  final int itemIndex;
  final double offset;
  final double maxRotation;
  final String path;
  @override
  Widget build(BuildContext context) {
    double defaultMargin = 10.0;
    var cardMarginTop = defaultMargin;
    var cardMarginBottom = defaultMargin;
    var currentIndex = int.tryParse(currentPage.toString().split('.')[0]);
    if (currentIndex != null) {
      if (offset > 0.0 && itemIndex == currentIndex) {
        cardMarginTop = defaultMargin - (defaultMargin * offset.abs());
        cardMarginBottom = defaultMargin + (20.0 * offset.abs());
      }
      if (offset < 0.0 && itemIndex == (currentIndex + 1)) {
        cardMarginTop = defaultMargin + (20.0 * offset.abs());
        cardMarginBottom = defaultMargin - (defaultMargin * offset.abs());
      }
    }
    return Container(
      margin: EdgeInsets.only(top: cardMarginTop, bottom: cardMarginBottom),
      child: Rotation3d(
        rotationX: offset * maxRotation,
        child: TappableEdges(
          child: VividCard(
            offset,
            path: path,
            cardWidth: cardWidth,
            cardHeight: (cardWidth * 1.479) + cardMarginTop + cardMarginBottom,
          ),
        ),
      ),
    );
  }
}
