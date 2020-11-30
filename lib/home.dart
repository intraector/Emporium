import 'package:Emporium/_constants/routes.dart';
import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/common_components/bottom_tab_bar_material.dart';
import 'package:Emporium/views/snap_scroll_parent.dart';
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
          children: [
            Expanded(
              child: SnapScrollParent(
                cardWidth: MediaQuery.of(context).size.width,
                isShadowsOn: settings.isShadowsOn,
                isRotationOn: settings.isRotationOn,
                isElasticOn: settings.isElasticOn,
                initialPage: GetIt.I<Settings>().currentPageParent,
                viewportFraction: settings.rowHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
