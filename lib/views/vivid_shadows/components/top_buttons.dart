import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class TopButtons extends StatelessWidget {
  TopButtons({this.width, this.maxOffset, this.globalOffset});
  final double width;
  final double maxOffset;
  final double globalOffset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: globalOffset,
      child: Container(
        margin: EdgeInsets.only(top: width * 0.13),
        width: width * 0.8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.stadium(),
                color: Colors.grey[700],
              ),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Nature',
                  style: GoogleFonts.roboto(
                      color: Colors.grey[200], fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.circle(),
                color: Colors.grey[700],
                surfaceIntensity: 1.0,
              ),
              child: Container(
                  padding: EdgeInsets.all(15.0),
                  // decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.45),
                  // shape: BoxShape.circle,
                  // ),
                  child: NeumorphicIcon(
                    Mdi.dotsVertical,
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.circle(),
                      surfaceIntensity: 1.0,
                      // color: Colors.grey,
                    ),
                    // color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
