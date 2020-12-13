import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/common_components/multi_gesture_detector.dart';
import 'package:Emporium/views/snap_scroll.dart';
import 'package:Emporium/views/vivid_shadows/components/bouncing_physics.dart';
import 'package:Emporium/views/vivid_shadows/components/clamping_physics.dart';
import 'package:Emporium/views/vivid_shadows/components/custom_page_view/custom_scroll_physics.dart';
import 'package:Emporium/views/vivid_shadows/components/custom_page_view/stage_scroll_physics.dart';
// import 'package:Emporium/views/vivid_shadows/components/custom_page_view/custom_page_view.dart'
// as cPV;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScrollParentGridView extends StatefulWidget {
  SnapScrollParentGridView({
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
  _SnapScrollParentGridViewState createState() => _SnapScrollParentGridViewState();
}

class _SnapScrollParentGridViewState extends State<SnapScrollParentGridView> {
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
  var horizontalViewportFraction = GetIt.I<Settings>().cellWidth;
  double scrollDelta = 0.0;
  // double moveThreshold = 1.5;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        // physics: PageScrollPhysics(),
        physics: BouncingPhysics(),
        // physics: NeverScrollableScrollPhysics(),
        // physics: ClampingPhysics(),
        // physics: ClampingScrollPhysics(),
        // physics: StageScrollingPhysics(),
        controller: _pageController,
        itemCount: cardWidthRatio.length,
        // dragStartBehavior: DragStartBehavior.down,
        scrollDirection: Axis.vertical,
        onPageChanged: (page) => GetIt.I<Settings>().currentPageParent = page,
        itemBuilder: (context, index) => SnapScroll(
              cardWidth: widget.cardWidth * cardWidthRatio[index],
              cardHeight: widget.cardWidth * cardWidthRatio[index] * cardHeightRatio[index],
              isShadowsOn: widget.isShadowsOn,
              isRotationOn: widget.isRotationOn,
              isElasticOn: widget.isElasticOn,
              viewportFraction: horizontalViewportFraction[index],
              initialPage: GetIt.I<Settings>().currentPage,
              onPageChanged: (page) => GetIt.I<Settings>().currentPage = page,
              // animateToPage: _pageController.animateToPage,
              index: index,
            ));
  }
}
