import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class Item extends StatefulWidget {
  Item({@required this.screenWidth, @required this.path});
  final double screenWidth;
  final String path;
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with TickerProviderStateMixin {
  double maxHeight;
  double padding = 0;
  double innerPadding;

  @override
  void initState() {
    innerPadding = widget.screenWidth * 0.06;
    super.initState();
    maxHeight = widget.screenWidth * 1.479;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      margin: EdgeInsets.symmetric(horizontal: padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: innerPadding,
                              right: innerPadding,
                              top: innerPadding,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.45),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Text(
                                    'Nature',
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(15.0),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.45),
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Mdi.dotsVertical,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          IgnorePointer(
                            child: Column(
                              children: [
                                Spacer(),
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
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w400),
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
                                  padding:
                                      EdgeInsets.symmetric(horizontal: innerPadding, vertical: 5.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                                        // textAlign: TextAlign.justify,
                                        style: GoogleFonts.roboto(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.w400),
                                      ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: innerPadding, vertical: 20.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('assets/images/avatar.png'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'TheOffWhiteDealer',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                '32.4K Likes  3 min ago',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w400),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
