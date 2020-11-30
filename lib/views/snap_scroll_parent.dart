import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/views/snap_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScrollParent extends StatefulWidget {
  SnapScrollParent({
    this.cardWidth,
    this.isShadowsOn,
    this.isRotationOn,
    this.isElasticOn,
    // this.cardHeight,
    this.viewportFraction = 1.0,
    this.initialPage = 0,
  });
  final double cardWidth;
  // final double cardHeight;
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool isElasticOn;
  final double viewportFraction;
  final int initialPage;
  @override
  _SnapScrollParentState createState() => _SnapScrollParentState();
}

class _SnapScrollParentState extends State<SnapScrollParent> {
  PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(
        initialPage: GetIt.I<Settings>().currentPageParent,
        viewportFraction: widget.viewportFraction);
    super.initState();
  }

  var cardWidthRatio = GetIt.I<Settings>().cardWidthRatio;
  var cardHeightRatio = GetIt.I<Settings>().cardHeightRatio;
  var horizontalViewportFraction = GetIt.I<Settings>().rowWidth;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        itemCount: cardWidthRatio.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (page) => GetIt.I<Settings>().currentPageParent = page,
        itemBuilder: (context, index) {
          return SnapScroll(
            cardWidth: widget.cardWidth * cardWidthRatio[index],
            cardHeight: widget.cardWidth * cardWidthRatio[index] * cardHeightRatio[index],
            isShadowsOn: widget.isShadowsOn,
            isRotationOn: widget.isRotationOn,
            elasticIsOn: widget.isElasticOn,
            viewportFraction: horizontalViewportFraction[index],
            initialPage: GetIt.I<Settings>().currentPage,
            onPageChanged: (page) => GetIt.I<Settings>().currentPage = page,
          );
        });
  }
}
