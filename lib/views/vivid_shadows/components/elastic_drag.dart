import 'package:flutter/material.dart';

class ElasticDrag extends StatelessWidget {
  ElasticDrag({
    this.currentPage,
    this.itemIndex,
    this.offset,
    @required this.child,
    this.isOn = true,
    this.margin = 10.0,
    this.elasticMargin = 20.0,
  });

  final double currentPage;
  final int itemIndex;
  final double offset;
  final bool isOn;
  final double margin;
  final double elasticMargin;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var cardMarginTop = margin;
    var cardMarginBottom = margin;
    var currentIndex = int.tryParse(currentPage.toString().split('.')[0]);
    if (currentIndex != null) {
      if (offset > 0.0 && itemIndex == currentIndex) {
        cardMarginTop = margin - (margin * offset.abs());
        cardMarginBottom = margin + (elasticMargin * offset.abs());
      }
      if (offset < 0.0 && itemIndex == (currentIndex + 1)) {
        cardMarginTop = margin + (elasticMargin * offset.abs());
        cardMarginBottom = margin - (margin * offset.abs());
      }
    }
    return Container(
      margin: isOn
          ? EdgeInsets.only(top: cardMarginTop, bottom: cardMarginBottom)
          : EdgeInsets.only(top: margin, bottom: margin),
      child: child,
    );
  }
}
