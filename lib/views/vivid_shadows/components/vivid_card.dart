import 'package:Emporium/views/vivid_shadows/components/background_picture.dart';
import 'package:Emporium/views/vivid_shadows/components/body_text.dart';
import 'package:Emporium/views/vivid_shadows/components/top_buttons.dart';
import 'package:Emporium/views/vivid_shadows/components/top_buttons_with_shadows.dart';
import 'package:Emporium/views/vivid_shadows/components/user_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class VividCard extends StatelessWidget {
  final bool shadowsIsOn;
  final double offset;
  final double cardWidth;
  final double cardHeight;
  final String path;

  const VividCard(
    this.offset, {
    Key key,
    @required this.cardWidth,
    @required this.cardHeight,
    @required this.path,
    @required this.shadowsIsOn,
  }) : super(key: key);

  final double maxParallax = 20;

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
          BackgroundPicture(path: path),
          _buildCityImage(),
          // City information
        ],
      ),
    );
  }

  Widget _buildCityImage() {
    // print('---------- cardHeight : $cardHeight');
    double globalOffset = offset * maxParallax;
    return Container(
      // color: Colors.pink.withOpacity(0.5),
      height: cardHeight,
      width: cardWidth,
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          shadowsIsOn
              ? TopButtonsWithShadows(
                  width: cardWidth, maxParallax: maxParallax, globalOffset: globalOffset)
              : TopButtons(width: cardWidth, maxParallax: maxParallax, globalOffset: globalOffset),
          BodyText(
            width: cardWidth,
            height: cardHeight,
            maxParallax: maxParallax,
            globalOffset: globalOffset,
          ),
          UserTile(
            width: cardWidth,
            height: cardHeight,
            maxParallax: maxParallax,
            globalOffset: globalOffset,
          ),
        ],
      ),
    );
  }
}
