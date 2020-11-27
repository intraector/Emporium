import 'package:Emporium/views/pop_unfold/components/item.dart';
import 'package:flutter/material.dart';

class ViewPopUnfold extends StatelessWidget {
  ViewPopUnfold(this.width);
  final double width;
  final double padding = 25.0;

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: padding, top: padding),
          child: Item(
            width: width,
            path: 'assets/images/oldman.jpg',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Item(
            width: width,
            path: 'assets/images/vertical.jpg',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: padding),
          child: Item(
            width: width,
            path: 'assets/images/smoke.jpg',
          ),
        ),
      ],
    );
  }
}
