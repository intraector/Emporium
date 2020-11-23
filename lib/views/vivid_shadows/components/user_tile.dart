import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserTile extends StatelessWidget {
  UserTile({
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
        margin: EdgeInsets.only(top: width * 1.2),
        width: width,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(backgroundImage: AssetImage('assets/images/avatar.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
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
      ),
    );
  }
}
