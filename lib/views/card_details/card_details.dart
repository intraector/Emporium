import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';

class CardDetails extends StatefulWidget {
  CardDetails({@required this.path, @required this.uid, @required this.screenSize});
  final String path;
  final String uid;
  final Size screenSize;

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> with TickerProviderStateMixin {
  // AnimationController animCtrlTitle;
  // Animation<Offset> animTitle;
  double titleOpacity = 0.0;
  double topButtonsPosition;
  var bodyColor = Colors.black;
  var bodyTextOpacity = 0.0;
  var bodyTagsOpacity = 0.0;
  var userTilePosition = -50.0;
  @override
  void initState() {
    super.initState();
    topButtonsPosition = -widget.screenSize.width / 2;
    // animCtrlTitle = AnimationController(vsync: this, duration: Duration(seconds: 1));
    // animTitle = Tween<Offset>(
    //   begin: Offset(0.0, -1.0),
    //   end: Offset(0.0, 1.0),
    // ).animate(CurvedAnimation(
    // parent: animCtrlTitle,
    // curve: Curves.linear,
    // ));
    // Future.delayed(Duration(milliseconds: 1700)).whenComplete(() => animCtrlTitle.forward());
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Future.delayed(Duration(milliseconds: 1700)).whenComplete(() => setState(() {
              topButtonsPosition = 0.0;
              Future.delayed(Duration(milliseconds: 500)).whenComplete(() => setState(() {
                    titleOpacity = 1.0;
                  }));
              Future.delayed(Duration(milliseconds: 800)).whenComplete(() => setState(() {
                    bodyColor = Colors.white;
                  }));
              Future.delayed(Duration(milliseconds: 1100)).whenComplete(() => setState(() {
                    bodyTextOpacity = 1.0;
                  }));
              Future.delayed(Duration(milliseconds: 1400)).whenComplete(() => setState(() {
                    bodyTagsOpacity = 1.0;
                  }));
              Future.delayed(Duration(milliseconds: 1700)).whenComplete(() => setState(() {
                    userTilePosition = 10.0;
                  }));
            })));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Hero(
                    tag: widget.uid,
                    flightShuttleBuilder: _buildFlightWidget,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        widget.path,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    top: 0.0,
                    left: topButtonsPosition,
                    curve: Curves.bounceOut,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(widget.screenSize.width * 0.02),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          borderRadius: BorderRadius.circular(25.0)),
                      child: Text(
                        'Nature',
                        style: GoogleFonts.roboto(
                            color: Colors.grey[200], fontSize: 18.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 1000),
                    top: 0.0,
                    right: topButtonsPosition,
                    curve: Curves.bounceOut,
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        padding: EdgeInsets.all(widget.screenSize.width * 0.02),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.45),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Mdi.dotsVertical,
                          color: Colors.white,
                        )),
                  ),
                  Positioned(
                    left: 0.0,
                    bottom: 0.0,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: titleOpacity,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'BIG TITLE',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    shadows: [Shadow(color: Colors.black, blurRadius: 15.0)],
                                    fontSize: 30.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: widget.screenSize.width,
                color: bodyColor,
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: bodyTextOpacity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Back in 1960 a man in England put a plant in a huge bottle. \nIn 1972 he watered it for the last time, but it keeps on thriving. The sealed bottle works like a mini ecosystem that recycles its nutrients and water.',
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(seconds: 1),
                          opacity: bodyTagsOpacity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.black,
                                  indent: widget.screenSize.width / 10,
                                  endIndent: widget.screenSize.width / 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                        child: Text(
                                      '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                                      maxLines: 3,
                                      style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.w400),
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 500),
                      bottom: userTilePosition,
                      left: 0.0,
                      right: 0.0,
                      curve: Curves.bounceOut,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: CircleAvatar(
                                        backgroundImage: AssetImage('assets/images/avatar.png')),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'TheOffWhiteDealer',
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        '32.4K Likes  3 min ago',
                                        style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightWidget(
      BuildContext flightContext,
      Animation<double> heroAnimation,
      HeroFlightDirection flightDirection,
      BuildContext fromHeroContext,
      BuildContext toHeroContext) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(25.0 - heroAnimation.value * 25.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // animCtrlTitle.dispose();
    super.dispose();
  }
}
