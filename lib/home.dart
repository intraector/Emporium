import 'package:emporium/_constants/settings.dart';
import 'package:emporium/common_components/bottom_tab_bar_material.dart';
import 'package:emporium/views/snap_scroll_parent_listview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ViewHome extends StatelessWidget {
  final settings = GetIt.I<Settings>();
  Widget build(BuildContext context) {
    GetIt.I<Settings>().cells.screenWidth = MediaQuery.of(context).size.width;
    GetIt.I<Settings>().cells.generateCells();
    return Scaffold(
      bottomNavigationBar: BottomTabBarMaterial(index: 1),
      backgroundColor: Colors.grey[500],
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: SnapScrollParentListView(
                initialScrollOffset: GetIt.I<Settings>().parentOffset,
                isShadowsOn: settings.isShadowsOn,
                isRotationOn: settings.isRotationOn,
                isElasticOn: settings.isElasticOn,
                cells: settings.cells,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
