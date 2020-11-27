import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  UserTile({
    this.width,
    this.height,
    this.maxParallax,
    this.globalOffset,
  });
  final double width;
  final double height;
  final double maxParallax;
  final double globalOffset;
  final double innerPadding = 0.0;
  @override
  Widget build(BuildContext context) {
    // print('---------- height : $height');
    return Container(
      // color: Colors.pink.withOpacity(0.5),
      width: width,
      height: height,
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, (globalOffset / 1.75) + maxParallax),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TheOffWhiteDealer',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '32.4K Likes  3 min ago',
                      style: GoogleFonts.roboto(
                          color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
