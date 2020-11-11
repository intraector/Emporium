import 'package:emporium/views/vivid_shadows/components/tappable_edges.dart';
import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class SnapScroll extends StatefulWidget {
  @override
  _SnapScrollState createState() => _SnapScrollState();
}

class _SnapScrollState extends State<SnapScroll> {
  List<int> data = [];
  int _focusedIndex = 0;
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      data.add(i);
    }
  }

  void _onItemFocus(int index) {
    _focusedIndex = index;
  }

  Widget _buildListItem(BuildContext context, int index) {
    var count = (index / 3).toStringAsFixed(1).split('.').last;
    Widget output;
    switch (int.parse(count)) {
      case 0:
        output = TappableEdges(
          width: MediaQuery.of(context).size.width,
          path: 'assets/images/vertical.jpg',
        );
        break;
      case 3:
        output = TappableEdges(
          width: MediaQuery.of(context).size.width,
          path: 'assets/images/bananas.png',
        );

        break;
      case 7:
        output = TappableEdges(
          width: MediaQuery.of(context).size.width,
          path: 'assets/images/smoke.jpg',
        );
        break;
    }
    return output;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 2)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ScrollSnapList(
        onItemFocus: _onItemFocus,
        itemSize: (MediaQuery.of(context).size.width * 1.479) + 40.0,
        itemBuilder: _buildListItem,
        itemCount: data.length,
        key: sslKey,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
