import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/views/snap_scroll.dart';
import 'package:Emporium/views/vivid_shadows/components/custom_page_view/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScrollParentListView extends StatefulWidget {
  SnapScrollParentListView({
    this.initialPage = 0,
    @required this.cellWidth,
    @required this.cellHeight,
    this.isShadowsOn,
    this.isRotationOn,
    this.isElasticOn,
  });
  final double cellWidth;
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool isElasticOn;
  final double cellHeight;
  final int initialPage;
  @override
  _SnapScrollParentListViewState createState() => _SnapScrollParentListViewState();
}

class _SnapScrollParentListViewState extends State<SnapScrollParentListView>
    with SingleTickerProviderStateMixin {
  var cardWidthRatio = GetIt.I<Settings>().cardWidthRatio;
  var cardHeightRatio = GetIt.I<Settings>().cardHeightRatio;
  var horizontalViewportFraction = GetIt.I<Settings>().cellWidth;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics:
            CustomScrollPhysics(itemDimension: widget.cellHeight, parent: BouncingScrollPhysics()),
        itemCount: cardWidthRatio.length,
        scrollDirection: Axis.vertical,
        itemExtent: widget.cellHeight,
        itemBuilder: (context, index) => SnapScroll(
              index: index,
              initialPage: GetIt.I<Settings>().currentPage,
              cardWidth: widget.cellWidth * cardWidthRatio[index],
              cardHeight: widget.cellWidth * cardWidthRatio[index] * cardHeightRatio[index],
              isShadowsOn: widget.isShadowsOn,
              isRotationOn: widget.isRotationOn,
              isElasticOn: widget.isElasticOn,
              viewportFraction: horizontalViewportFraction[index],
              onPageChanged: (page) => GetIt.I<Settings>().currentPage = page,
              verticalPaddingRatio: 0.005,
              horizontalPaddingRatio: 0.01,
            ));
  }
}
