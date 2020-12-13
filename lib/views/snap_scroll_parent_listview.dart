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
  ScrollPhysics physics;
  @override
  void initState() {
    // itemExtent = widget.cells[0].height;
    physics = CustomScrollPhysics(cells: widget.cells, parent: BouncingScrollPhysics());
    controller = ScrollController(initialScrollOffset: widget.initialScrollOffset);
    // controller.addListener(() {
    //   var newExtent = settings.cells.itemExtent(controller.offset);
    //   if (newExtent != itemExtent) {
    //     setState(() {
    //       itemExtent = newExtent;
    //       print('---------- itemExtent : $itemExtent');
    //       physics = CustomScrollPhysics(itemExtent: itemExtent, parent: BouncingScrollPhysics());
    //     });
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: physics,
        itemCount: widget.cells.list.length,
        controller: controller,
        scrollDirection: Axis.vertical,
        // itemExtent: widget.cells[0].height,
        itemBuilder: (context, index) => SizedBox(
              height: widget.cells.list[index].height,
              child: SnapScroll(
                index: index,
                initialPage: GetIt.I<Settings>().currentPage,
                cell: widget.cells.list[index],
                isShadowsOn: widget.isShadowsOn,
                isRotationOn: widget.isRotationOn,
                isElasticOn: widget.isElasticOn,
                onPageChanged: (page) => settings.currentPage = page,
              ),
            ));
  }
}
