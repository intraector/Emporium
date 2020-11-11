import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key key,
    @required double paddingWidth,
    @required double paddingHeight,
    @required this.cardWidth,
    @required this.cardHeight,
    @required this.text,
  })  : _paddingWidth = paddingWidth,
        _paddingHeight = paddingHeight,
        super(key: key);

  final double _paddingWidth;
  final double _paddingHeight;
  final double cardWidth;
  final double cardHeight;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: _paddingWidth, vertical: _paddingHeight),
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: Colors.indigo[200],
          borderRadius: BorderRadius.all(
              Radius.circular(_paddingHeight * _paddingWidth / 7)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
