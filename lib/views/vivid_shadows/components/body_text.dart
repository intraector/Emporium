import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  BodyText({
    @required this.width,
    @required this.height,
    @required this.maxParallax,
    @required this.globalOffset,
  });
  final double width;
  final double height;
  final double maxParallax;
  final double globalOffset;
  final double innerPadding = 20.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: innerPadding,
        right: innerPadding,
        bottom: (globalOffset / 1.5) + maxParallax + height * 0.15,
      ),
      // color: Colors.pink.withOpacity(0.5),
      alignment: Alignment.bottomCenter,
      width: width,
      height: height,
      constraints: BoxConstraints(maxHeight: height),
      child: IgnorePointer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Text(
                      'Back in 1960 a man in England put a plant in a huge bottle. \nIn 1972 he watered it for the last time, but it keeps on thriving. The sealed bottle works like a mini ecosystem that recycles its nutrients and water.',
                      maxLines: 6,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400),
                      // softWrap: false,
                      overflow: TextOverflow.fade,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: innerPadding,
              color: Colors.white,
              indent: innerPadding,
              endIndent: innerPadding,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: innerPadding, vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                        child: Text(
                      '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                      maxLines: 3,
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w400),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ))
                  ],
                ),
              ),
            ),
            // SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
