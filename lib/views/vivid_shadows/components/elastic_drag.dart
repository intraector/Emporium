import 'package:flutter/material.dart';

class ElasticDrag extends StatelessWidget {
  ElasticDrag({
    this.currentPage,
    this.itemIndex,
    this.offset,
    @required this.child,
    this.isOn = true,
    this.margin,
    this.elasticMargin,
    this.axis = Axis.vertical,
  });

  final double currentPage;
  final int itemIndex;
  final double offset;
  final bool isOn;
  final double margin;
  final double elasticMargin;
  final Axis axis;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    var cardMarginStart = margin;
    var cardMarginEnd = margin;
    var currentIndex = int.tryParse(currentPage.toString().split('.')[0]);
    if (currentIndex != null) {
      if (offset > 0.0 && itemIndex == currentIndex) {
        cardMarginStart = margin - (margin * offset.abs());
        cardMarginEnd = margin + (elasticMargin * offset.abs());
      }
      if (offset < 0.0 && itemIndex == (currentIndex + 1)) {
        cardMarginStart = margin + (elasticMargin * offset.abs());
        cardMarginEnd = margin - (margin * offset.abs());
      }
    }
    EdgeInsets outputMargin;
    switch (axis) {
      case Axis.vertical:
        outputMargin = EdgeInsets.fromLTRB(margin, cardMarginStart, margin, cardMarginEnd);
        break;
      case Axis.horizontal:
        outputMargin = EdgeInsets.fromLTRB(cardMarginStart, margin, cardMarginEnd, margin);
        break;
    }
    return Container(
      margin: isOn ? outputMargin : EdgeInsets.all(margin),
      child: child,
    );
  }
}
