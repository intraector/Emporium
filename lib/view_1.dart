import 'package:emporium/unfolded.dart';
import 'package:flutter/material.dart';

class View1 extends StatefulWidget {
  View1(this.height);
  final double height;
  @override
  _View1State createState() => _View1State();
}

class _View1State extends State<View1> with TickerProviderStateMixin {
  double aspectRatio = 1.0;

  Widget build(BuildContext context) {
    return ListView(
      children: [
        Unfolded(
          height: widget.height,
          path: 'assets/images/oldman.jpg',
        ),
        Unfolded(
          height: widget.height,
          path: 'assets/images/vertical.jpg',
        ),
      ],
    );
  }
}
