import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class TopButtons extends StatelessWidget {
  TopButtons({this.width, this.maxParallax, this.globalOffset});
  final double width;
  final double maxParallax;
  final double globalOffset;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin:
          EdgeInsets.only(top: maxParallax - (globalOffset / 1.75) + 10.0, left: 20.0, right: 20.0),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45), borderRadius: BorderRadius.circular(25.0)),
            child: Text(
              'Nature',
              style: GoogleFonts.roboto(
                  color: Colors.grey[200], fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
          ),

          Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Mdi.dotsVertical,
                color: Colors.white,
              )),
          // ),
        ],
      ),
    );
  }
}
