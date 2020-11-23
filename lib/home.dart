import 'package:emporium/views/snap_scroll.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emporium'),
      //   backgroundColor: Colors.brown,
      // ),
      backgroundColor: Colors.grey[500],
      // body: ViewPopUnfold(width),
      // body: ViewVividShadows(width),
      body: SnapScroll(MediaQuery.of(context).size.width),
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
