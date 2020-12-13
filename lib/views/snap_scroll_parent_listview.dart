import 'package:Emporium/_constants/settings.dart';
import 'package:Emporium/views/snap_scroll.dart';
import 'package:Emporium/views/vivid_shadows/components/custom_page_view/custom_scroll_physics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SnapScrollParentListView extends StatefulWidget {
  SnapScrollParentListView({
    @required this.cells,
    this.isShadowsOn,
    this.isRotationOn,
    this.isElasticOn,
    this.initialScrollOffset = 0.0,
  });
  final bool isShadowsOn;
  final bool isRotationOn;
  final bool isElasticOn;
  final Cells cells;
  final double initialScrollOffset;
  @override
  _SnapScrollParentListViewState createState() => _SnapScrollParentListViewState();
}

class _SnapScrollParentListViewState extends State<SnapScrollParentListView>
    with SingleTickerProviderStateMixin {
  var settings = GetIt.I<Settings>();
  ScrollController controller;
  double itemExtent;
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
        physics: CustomScrollPhysics(cells: widget.cells, parent: BouncingScrollPhysics()),
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
