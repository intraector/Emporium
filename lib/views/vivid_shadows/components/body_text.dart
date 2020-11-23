import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyText extends StatelessWidget {
  BodyText({
    this.width,
    this.maxOffset,
    this.globalOffset,
  });
  final double width;
  final double maxOffset;
  final double globalOffset;
  final double innerPadding = 0.0;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: globalOffset,
      child: Container(
        margin: EdgeInsets.only(top: width * 0.4),
        width: width,
        child: IgnorePointer(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: innerPadding,
                  right: innerPadding,
                  top: innerPadding,
                  bottom: 8.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        'Back in 1960 a man in England put a plant in a huge bottle. \nIn 1972 he watered it for the last time, but it keeps on thriving. The sealed bottle works like a mini ecosystem that recycles its nutrients and water.',
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.roboto(
                            color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w400),
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: innerPadding, vertical: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Text(
                      '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                      // textAlign: TextAlign.justify,
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.w400),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
