import 'dart:math' as math;

import 'package:emporium/scrollTypeOne/custom_scroll_physics.dart';
import 'package:emporium/scrollTypeOne/horizontal_scroller.dart';
import 'package:emporium/scrollTypeOne/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollTypeOne extends StatefulWidget {
  final int dimension;
  final double padding;
  final double aspectRatio;
  final int totalItemsCountHeight;
  final int totalItemsCountWidth;

  ScrollTypeOne({
    @required this.dimension,
    @required this.padding,
    @required this.aspectRatio,
    @required this.totalItemsCountHeight,
    @required this.totalItemsCountWidth,
  });

  @override
  _ScrollTypeOneState createState() => _ScrollTypeOneState();
}

class _ScrollTypeOneState extends State<ScrollTypeOne> {
  int _totalItemsCountHeight = 100;
  int _totalItemsCountWidth = 100;
  List<PageController> _horizontalControllers = [];
  List<int> _horizontalControllersPages = [];
  double _paddingWidth;
  double _paddingHeight;
  ScrollController _verticalController;
  ScrollPhysics _verticalScrollPhysics;

  int _dimensionWidth;
  double _cardWidth;
  double _cardHeight;

  double _aspectRatio = 4 / 3;

  // final double _aspectRatio = 16 / 9;

  @override
  void initState() {
    super.initState();

    _dimensionWidth = widget.dimension;
    _totalItemsCountWidth = widget.totalItemsCountWidth ~/ widget.dimension;
    _totalItemsCountHeight = widget.totalItemsCountHeight;
    _aspectRatio = widget.aspectRatio;
    if (widget.padding > Sizes.screenWidth)
      _paddingWidth = 8;
    else
      _paddingWidth = widget.padding;
    for (int i = 0; i < _totalItemsCountHeight; i++) {
      _horizontalControllersPages.add(0);
      PageController controller = PageController();
      controller.addListener(() {
        setState(() {
          _horizontalControllersPages[i] = controller.page.round().toInt();
        });
      });
      _horizontalControllers.add(controller);
    }
    _verticalController = ScrollController();
    _verticalController.addListener(() {
      setState(() {
        for (int i = 0; i < _totalItemsCountHeight; i++) {
          if (_horizontalControllers[i].hasClients)
            _horizontalControllers[i].jumpToPage(_horizontalControllersPages[i]);
        }
      });
    });
    _cardWidth = (Sizes.screenWidth - _paddingWidth * _dimensionWidth * 2) / _dimensionWidth;
    _cardHeight = _cardWidth * _aspectRatio;
    _paddingHeight = _paddingWidth;

    double rows = ((Sizes.screenHeight -
                Sizes.topPadding -
                (Sizes.screenHeight - Sizes.topPadding) % _cardHeight) /
            _cardHeight)
        .roundToDouble();
    int totalPagesCount = _totalItemsCountHeight ~/ rows;
    _dimension = rows * _cardHeight;
    pages = List.generate(totalPagesCount, (index) => index);
    _verticalScrollPhysics = CustomScrollPhysics(itemDimension: _dimension);
  }

  double _dimension;
  List<int> pages;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          (_cardHeight > 4 || _cardWidth > 4)
              ? ListView.builder(
                  controller: _verticalController,
                  physics: _verticalScrollPhysics,
                  scrollDirection: Axis.vertical,
                  itemCount: _totalItemsCountHeight,
                  itemBuilder: (BuildContext context, int i) {
                    return HorizontalScroller(
                        cardHeight: _cardWidth * 1.479,
                        horizontalController: _horizontalControllers[i],
                        count: _totalItemsCountWidth,
                        dimensionWidth: _dimensionWidth,
                        paddingWidth: _paddingWidth,
                        paddingHeight: _paddingHeight,
                        cardWidth: _cardWidth,
                        rowIndex: i);
                  },
                )
              : Center(
                  child: Text('Некорректно заданы параметры сетки', textAlign: TextAlign.center),
                ),
          Container(
            width: 26,
            child: GestureDetector(
              onHorizontalDragEnd: (dragStartDetals) {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  double roundDouble(double value, int places) {
    double mod = math.pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
