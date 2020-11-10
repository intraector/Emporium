import 'dart:math';
import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  Item({@required this.width, @required this.path});
  final double width;
  final String path;
  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with TickerProviderStateMixin {
  double maxHeight;
  double initialPadding = 20;
  double innerPadding;
  bool isUnfolded = false;

  AnimationController _controllerMain;
  AnimationController _controllerSecond;

  CurvedAnimation _animationMain;
  CurvedAnimation _animationSecondary;

  @override
  void initState() {
    super.initState();
    innerPadding = widget.width * 0.06;
    maxHeight = widget.width - initialPadding;
    _controllerMain = AnimationController(
      value: 1.0,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationMain = CurvedAnimation(
      parent: _controllerMain,
      curve: MainCurve(),
    );
    _controllerSecond = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationSecondary = CurvedAnimation(
      parent: _controllerSecond,
      curve: SecondCurve(),
      // curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationMain,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.symmetric(
                horizontal: initialPadding * _animationMain.value + (initialPadding * 0.5)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                color: Colors.grey.shade300,
                child: Stack(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              AnimatedBuilder(
                                animation: _animationSecondary,
                                builder: (context, child) {
                                  return Container(
                                    alignment: Alignment.bottomCenter,
                                    height: calcHeight(),
                                    child: IgnorePointer(
                                      child: ListView(
                                        shrinkWrap: true,
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
                                                    style: TextStyle(fontSize: 18.0),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Divider(height: innerPadding),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: innerPadding, vertical: 5.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  '#History #England #Nature #Content4app #Ecology #Men #Announcements',
                                                  // textAlign: TextAlign.justify,
                                                  style: TextStyle(fontSize: 17.0),
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
                                                      backgroundImage:
                                                          AssetImage('assets/images/avatar.png'),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'TheOffWhiteDealer',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18.0),
                                                        ),
                                                        Text(
                                                          '32.4K Likes  3 min ago',
                                                          style: TextStyle(fontSize: 15.0),
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
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        isUnfolded = !isUnfolded;
                        if (isUnfolded) {
                          await _controllerMain.reverse();
                          await _controllerSecond.forward();
                        } else {
                          await _controllerSecond.reverse();
                          await _controllerMain.forward();
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        // child: Container(
                        //   alignment: Alignment.center,
                        //   color: Colors.transparent,
                        // ),
                        child: Image.asset(
                          widget.path,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  double calcHeight() {
    return maxHeight +
        (maxHeight * 0.9 * _animationSecondary.value) -
        (maxHeight * 0.16 * _animationMain.value);
  }

  @override
  void dispose() {
    _controllerMain.dispose();
    super.dispose();
  }
}

class MainCurve extends Curve {
  @override
  double transformInternal(double t) => sin(t * pi * 1.62 - 2.55) * 0.9 + 0.5;
}

class SecondCurve extends Curve {
  @override
  double transformInternal(double t) => sin(t * pi * 1.36 - 1.6) * 0.7 + 0.7;
}
