import 'dart:ui';

import 'package:Emporium/views/snap_scroll.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool shadowsIsOn = false;
  bool rotationIsOn = false;
  bool elasticIsOn = false;
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Emporium'),
      //   backgroundColor: Colors.brown,
      // ),
      backgroundColor: Colors.grey[500],

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: kMinInteractiveDimension,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Elastic',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                      ),
                      Switch(
                        onChanged: (isChecked) => setState(() => elasticIsOn = isChecked),
                        value: elasticIsOn,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Rot.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                      ),
                      Switch(
                        onChanged: (isChecked) => setState(() => rotationIsOn = isChecked),
                        value: rotationIsOn,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Shadows',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black87,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                      ),
                      Switch(
                        onChanged: (isChecked) => setState(() => shadowsIsOn = isChecked),
                        value: shadowsIsOn,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SnapScroll(
                screenWidth: MediaQuery.of(context).size.width,
                shadowsIsOn: shadowsIsOn,
                rotationIsOn: rotationIsOn,
                elasticIsOn: elasticIsOn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
