import 'package:emporium/scrollTypeOne/custom_card.dart';
import 'package:emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:flutter/material.dart';

class HorizontalScroller extends StatelessWidget {
  const HorizontalScroller({
    Key key,
    @required this.cardHeight,
    @required this.horizontalController,
    @required this.count,
    @required int dimensionWidth,
    @required double paddingWidth,
    @required double paddingHeight,
    @required this.cardWidth,
    @required this.rowIndex,
  })  : _dimensionWidth = dimensionWidth,
        _paddingWidth = paddingWidth,
        _paddingHeight = paddingHeight,
        super(key: key);

  final double cardHeight;
  final PageController horizontalController;
  final int count;
  final int _dimensionWidth;
  final double _paddingWidth;
  final double _paddingHeight;
  final double cardWidth;
  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      child: PageView.builder(
        controller: horizontalController,
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (BuildContext context, int j) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _dimensionWidth,
            itemBuilder: (BuildContext context, int s) {
              return TappableEdges(
                width: cardWidth,
                path: 'assets/images/bananas.png',
              );
            },
          );
        },
      ),
    );
  }
}
