import 'package:emporium/views/vivid_shadows/components/background_picture.dart';
import 'package:emporium/views/vivid_shadows/components/body_text.dart';
import 'package:emporium/views/vivid_shadows/components/top_buttons.dart';
import 'package:emporium/views/vivid_shadows/components/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class VividCard extends StatelessWidget {
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final String path;

  const VividCard(this.offset,
      {Key key, this.cardWidth = 250, this.cardHeight, @required this.path})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth,
      // margin: EdgeInsets.only(top: 8),
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          BackgroundPicture(path: path),
          Positioned(top: -15, child: _buildCityImage()),
          // City information
        ],
      ),
    );
  }

  Widget _buildCityImage() {
    double maxParallax = 20;
    double globalOffset = offset * maxParallax;
    double cardPadding = 28;
    double containerWidth = cardWidth - cardPadding;
    return Container(
      height: cardHeight,
      width: containerWidth,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          TopButtons(
              width: containerWidth * .8, maxOffset: maxParallax * .1, globalOffset: globalOffset),
          BodyText(
              width: containerWidth * .8, maxOffset: maxParallax * .1, globalOffset: globalOffset),
          UserTile(
              width: containerWidth * .8, maxOffset: maxParallax * .1, globalOffset: globalOffset),
        ],
      ),
    );
  }

  // Widget _buildPositionedLayer(String path, double width, double maxOffset, double globalOffset) {
  //   double cardPadding = 24;
  //   double layerWidth = cardWidth - cardPadding;
  //   return Positioned(
  //       left: ((layerWidth * .5) - (width / 2) - offset * maxOffset) + globalOffset,
  //       bottom: cardHeight * .45,
  //       child: Image.asset(
  //         path,
  //         width: width,
  //         // package: App.pkg,
  //       ));
  // }

}
