// import 'package:emporium/_constants/settings.dart';
// import 'package:emporium/views/snap_scroll.dart';
// import 'package:emporium/views/vivid_shadows/components/bouncing_physics.dart';
// import 'package:emporium/views/vivid_shadows/components/clamping_physics.dart';
// import 'package:emporium/views/vivid_shadows/components/custom_page_view/custom_page_view.dart'
//     as cPV;
// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';

// class SnapScrollParent extends StatefulWidget {
//   SnapScrollParent({
//     this.cardWidth,
//     this.isShadowsOn,
//     this.isRotationOn,
//     this.isElasticOn,
//     // this.cardHeight,
//     this.viewportFraction = 1.0,
//     this.initialPage = 0,
//   });
//   final double cardWidth;
//   // final double cardHeight;
//   final bool isShadowsOn;
//   final bool isRotationOn;
//   final bool isElasticOn;
//   final double viewportFraction;
//   final int initialPage;
//   @override
//   _SnapScrollParentState createState() => _SnapScrollParentState();
// }

// class _SnapScrollParentState extends State<SnapScrollParent> {
//   cPV.PageController _pageController;
//   @override
//   void initState() {
//     _pageController = cPV.PageController(
//         initialPage: GetIt.I<Settings>().currentPageParent,
//         viewportFraction: widget.viewportFraction);
//     super.initState();
//   }

//   double scrollDelta = 0.0;
//   // double moveThreshold = 1.5;

//   @override
//   Widget build(BuildContext context) {
//     return cPV.CustomPageView.builder(
//         // physics: PageScrollPhysics(),
//         physics: BouncingPhysics(),
//         // physics: NeverScrollableScrollPhysics(),
//         // physics: ClampingPhysics(),
//         // physics: ClampingScrollPhysics(),
//         // physics: StageScrollingPhysics(),
//         controller: _pageController,
//         pageSnapping: false,
//         itemCount: widget.cells.length,
//         // dragStartBehavior: DragStartBehavior.down,
//         scrollDirection: Axis.vertical,
//         onPageChanged: (page) => GetIt.I<Settings>().currentPageParent = page,
//         itemBuilder: (context, index) => SnapScroll(
//               cardWidth: widget.cardWidth * cardWidthRatio[index],
//               cardHeight: widget.cardWidth * cardWidthRatio[index] * cardHeightRatio[index],
//               isShadowsOn: widget.isShadowsOn,
//               isRotationOn: widget.isRotationOn,
//               isElasticOn: widget.isElasticOn,
//               cellWidth: horizontalViewportFraction[index],
//               initialPage: GetIt.I<Settings>().currentPage,
//               onPageChanged: (page) => GetIt.I<Settings>().currentPage = page,
//               // animateToPage: _pageController.animateToPage,
//               index: index,
//             ));
//   }
// }
