import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../_constants/settings.dart';
import 'snap_scroll.dart';
import 'vivid_shadows/components/custom_page_view/custom_scroll_physics.dart';

class SnapScrollParentListView extends StatefulWidget {
  const SnapScrollParentListView({
    super.key,
    required this.cells,
    this.isShadowsOn = true,
    this.isRotationOn = true,
    this.isElasticOn = true,
    this.initialScrollOffset = 0.0,
  });

  final Cells cells;
  final double initialScrollOffset;
  final bool isElasticOn;
  final bool isRotationOn;
  final bool isShadowsOn;

  @override
  SnapScrollParentListViewState createState() => SnapScrollParentListViewState();
}

class SnapScrollParentListViewState extends State<SnapScrollParentListView> with SingleTickerProviderStateMixin {
  late ScrollController controller;
  var settings = GetIt.I<Settings>();

  // double itemExtent;
  @override
  void initState() {
    controller = ScrollController(initialScrollOffset: widget.initialScrollOffset);
    controller.addListener(() {
      settings.parentOffset = controller.offset;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: CustomScrollPhysics(
          cells: widget.cells,
          parent: const BouncingScrollPhysics(),
        ),
        itemCount: widget.cells.list.length,
        controller: controller,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) => SizedBox(
              height: widget.cells.list[index].height,
              child: SnapScroll(
                index: index,
                initialPage: settings.cells.list[index].initialPage,
                cell: widget.cells.list[index],
                isShadowsOn: widget.isShadowsOn,
                isRotationOn: widget.isRotationOn,
                isElasticOn: widget.isElasticOn,
                onPageChanged: (page) => settings.cells.list[index].initialPage = page,
              ),
            ));
  }
}
