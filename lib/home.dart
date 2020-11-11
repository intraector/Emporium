import 'package:emporium/views/vivid_shadows/view_vivid_shadows.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emporium'),
      //   backgroundColor: Colors.brown,
      // ),
      // backgroundColor: Colors.brown,
      // body: ViewPopUnfold(width),
      body: ViewVividShadows(width),
    );
  }
}
