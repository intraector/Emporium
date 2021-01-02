import 'package:Emporium/views/card_details/card_details.dart';
import 'package:Emporium/views/vivid_shadows/components/background_picture.dart';
import 'package:Emporium/views/vivid_shadows/components/body_text.dart';
import 'package:Emporium/views/vivid_shadows/components/top_buttons.dart';
import 'package:Emporium/views/vivid_shadows/components/top_buttons_with_shadows.dart';
import 'package:Emporium/views/vivid_shadows/components/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class VividCard extends StatelessWidget {
  final bool shadowsIsOn;
  final double offsetRatio;
  final double cardWidth;
  final double cardHeight;
  final String path;
  final Axis axis;
  final String uid;

  const VividCard(
    this.offsetRatio, {
    Key key,
    @required this.cardWidth,
    @required this.cardHeight,
    @required this.path,
    @required this.shadowsIsOn,
    @required this.axis,
    @required this.uid,
  })  : maxOffsetVertical = cardWidth * 0.06,
        maxOffsetHorizontal = cardHeight * 0.06,
        super(key: key);

  final double maxOffsetVertical;
  final double maxOffsetHorizontal;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink.withOpacity(0.5),

      width: cardWidth,
      height: cardHeight,
      // margin: EdgeInsets.only(top: 8),
      child: Stack(
        // overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Hero(
            tag: uid,
            child: BackgroundPicture(path: path),
          ),
          _buildCityImage(),
          // City information
        ],
      ),
    );
  }

  Widget _buildCityImage() {
    double topButtonsVerticalMargin = maxOffsetVertical + 10.0;
    double leftMargin = maxOffsetHorizontal + 10.0;
    double rightMargin = maxOffsetHorizontal + 10.0;
    double bodyTextVerticalMargin = maxOffsetVertical + cardHeight * 0.15;
    double userTileVerticalMargin = maxOffsetVertical;
    switch (axis) {
      case Axis.vertical:
        {
          double offset = offsetRatio * maxOffsetVertical;
          topButtonsVerticalMargin = maxOffsetVertical - (offset / 1.75) + 10.0;
          bodyTextVerticalMargin = (offset / 1.5) + maxOffsetVertical + cardHeight * 0.15;
          userTileVerticalMargin = (offset / 1.75) + maxOffsetVertical;
        }
        break;
      case Axis.horizontal:
        {
          double offset = offsetRatio * maxOffsetHorizontal;
          leftMargin = (maxOffsetHorizontal + offset) + 10.0;
          rightMargin = (maxOffsetHorizontal - offset) + 10.0;
        }
        break;
    }
    return Container(
      // color: Colors.pink.withOpacity(0.5),
      height: cardHeight,
      width: cardWidth,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: topButtonsVerticalMargin,
              left: leftMargin,
              right: rightMargin,
            ),
            child: shadowsIsOn
                ? TopButtonsWithShadows(width: cardWidth)
                : TopButtons(width: cardWidth),
          ),
          Positioned(
            // left: leftMargin,
            // right: rightMargin,
            child: Container(
              width: cardWidth,
              margin: EdgeInsets.only(
                // top: bodyTextVerticalMargin,
                bottom: bodyTextVerticalMargin,
                left: cardWidth * 0.05,
                right: cardWidth * 0.05,
              ),
              child: BodyText(width: cardWidth, height: cardHeight),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(leftMargin, 0.0, rightMargin, userTileVerticalMargin),
            child: UserTile(width: cardWidth, height: cardHeight),
          ),
        ],
      ),
    );
  }
}
