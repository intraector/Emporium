import 'package:emporium/views/vivid_shadows/components/item.dart';
import 'package:emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:flutter/material.dart';

class ViewVividShadows extends StatelessWidget {
  ViewVividShadows(this.width);
  final double width;
  final double padding = 25.0;

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: padding, top: padding),
          child: TappableEdges(
            screenWidth: width,
            path: 'assets/images/bananas.png',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Item(
            screenWidth: width,
            path: 'assets/images/vertical.jpg',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Item(
            screenWidth: width,
            path: 'assets/images/smoke.jpg',
          ),
        ),
      ],
    );
  }
}
