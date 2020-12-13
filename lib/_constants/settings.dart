import 'package:flutter/foundation.dart';

class Settings {
  double parentOffset = 0;
  bool isShadowsOn = false;
  bool isRotationOn = true;
  bool isElasticOn = true;
  double cellHeightRatio = 1.0;
  Effect effect = Effect.none;
  var cells = Cells();
}

enum Effect { first, second, third, forth, none }

class Cells {
  double screenWidth = 0.0;
  List<Cell> list = [];
  var extents = <MapEntry<double, double>>[];
  double itemExtent(double offset) {
    double output;
    var sumOfExtents = 0.0;
    for (var cell in list) {
      sumOfExtents += cell.height;
      if (offset <= sumOfExtents) {
        output = cell.height;
        break;
      }
    }
    return output;
  }

  MapEntry<double, double> getPage(double offset) {
    MapEntry<double, double> output;
    for (var entry in extents) {
      if (offset >= entry.key && offset <= (entry.key + entry.value)) {
        output = entry;
      }
    }
    return output;
  }

  void generateExtents() {
    extents.clear();
    var sumOfExtents = 0.0;
    for (var cell in list) {
      extents.add(MapEntry(sumOfExtents, cell.height));
      sumOfExtents += cell.height;
    }
  }

  void generateCells() {
    if (list.isEmpty) {
      list = [
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.7,
          widthRatio: 0.7,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
          initialPage: 1,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 0.5,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
          initialPage: 2,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 2.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 0.5,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
          initialPage: 2,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
        Cell(
          screenWidth: screenWidth,
          heightRatio: 1.0,
          widthRatio: 1.0,
          paddingRatioH: 0.01,
          paddingRatioV: 0.005,
          onUpdate: generateExtents,
        ),
      ];
      generateExtents();
    }
  }
}

class Cell {
  Cell({
    @required this.screenWidth,
    @required this.widthRatio,
    @required heightRatio,
    @required this.paddingRatioH,
    @required this.paddingRatioV,
    this.initialPage = 0,
    this.onUpdate,
  }) : _heightRatio = heightRatio;
  void Function() onUpdate;
  double screenWidth;
  double widthRatio;
  double _heightRatio;
  double get heightRatio => _heightRatio;
  set heightRatio(double value) {
    _heightRatio = value;
    onUpdate();
  }

  int initialPage;

  double get width => screenWidth * widthRatio;
  double get height => width * heightRatio;
  double paddingRatioH;
  double paddingRatioV;
  int cardsQty = 8;
}
