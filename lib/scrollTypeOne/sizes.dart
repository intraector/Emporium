
import 'package:flutter/material.dart';

class Sizes {
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;
  static double topPadding;
  static MediaQueryData _mediaQueryData;

  void init(BuildContext context) async {
    _mediaQueryData = MediaQuery.of(context);
    topPadding = _mediaQueryData.padding.top;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
