import 'package:emporium/view_1.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('Emporium')),
      body: View1(_height),
    );
  }
}
