import 'package:Emporium/_constants/routes.dart';
import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/common_components/bottom_tab_bar_material.dart';
import 'package:Emporium/views/snap_scroll_parent.dart';
import 'package:Emporium/views/snap_scroll_parent_gridview.dart';
import 'package:Emporium/views/snap_scroll_parent_listview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewHome extends StatefulWidget {
  @override
  _ViewHomeState createState() => _ViewHomeState();
}

class _ViewHomeState extends State<ViewHome> {
  var settings = GetIt.I<Settings>();
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emporium'),
      //   backgroundColor: Colors.brown,
      // ),
      bottomNavigationBar: BottomTabBarMaterial(Paths.home),
      backgroundColor: Colors.grey[500],

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SnapScrollParentListView(
                initialPage: GetIt.I<Settings>().currentPageParent,
                cellWidth: MediaQuery.of(context).size.width,
                cellHeight: MediaQuery.of(context).size.width * settings.cellHeightRatio,
                isShadowsOn: settings.isShadowsOn,
                isRotationOn: settings.isRotationOn,
                isElasticOn: settings.isElasticOn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
