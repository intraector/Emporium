import 'package:emporium/scrollTypeOne/scroll_type_one.dart';
import 'package:emporium/scrollTypeOne/sizes.dart';
import 'package:emporium/views/snap_scroll.dart';
import 'package:emporium/views/vivid_shadows/view_vivid_shadows.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    Sizes().init(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emporium'),
      //   backgroundColor: Colors.brown,
      // ),
      // backgroundColor: Colors.brown,
      // body: ViewPopUnfold(width),
      // body: ViewVividShadows(width),
      body: SnapScroll(),
      // body: ScrollTypeOne(
      //   dimension: 1,
      //   padding: 4.0,
      //   totalItemsCountHeight: 100,
      //   totalItemsCountWidth: 100,
      //   aspectRatio: 16 / 9,
      // ),
    );
  }
}
