import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class TopButtons extends StatelessWidget {
  TopButtons({@required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Container(
              padding: EdgeInsets.all(width * 0.015),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45), borderRadius: BorderRadius.circular(25.0)),
              child: Text(
                'Nature',
                style: GoogleFonts.roboto(
                    color: Colors.grey[200], fontSize: 18.0, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Flexible(
            child: Container(
                padding: EdgeInsets.all(width * 0.015),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Mdi.dotsVertical,
                  color: Colors.white,
                )),
          ),
          // ),
        ],
      ),
    );
  }
}
