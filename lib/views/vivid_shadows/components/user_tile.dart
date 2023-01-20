import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  UserTile({this.width, this.height});
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink.withOpacity(0.5),
      width: width,
      height: height,
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TheOffWhiteDealer',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  '32.4K Likes  3 min ago',
                  style: GoogleFonts.roboto(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.w400),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
