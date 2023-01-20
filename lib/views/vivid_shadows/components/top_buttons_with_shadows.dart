import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class TopButtonsWithShadows extends StatelessWidget {
  TopButtonsWithShadows({required this.width});
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
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.stadium(),
                color: Colors.grey[700],
              ),
              child: Container(
                padding: EdgeInsets.all(width * 0.015),
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.45), borderRadius: BorderRadius.circular(25.0)),
                child: Text(
                  'Nature',
                  style: GoogleFonts.roboto(color: Colors.grey[200], fontSize: 18.0, fontWeight: FontWeight.w400),
                ),
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
                padding: EdgeInsets.all(width * 0.015),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  shape: BoxShape.circle,
                ),
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
    );
  }
}
