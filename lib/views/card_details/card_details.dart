import 'package:flutter/material.dart';

class CardDetails extends StatelessWidget {
  CardDetails({@required this.path, @required this.uid});
  final String path;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Hero(
              tag: uid,
              flightShuttleBuilder: _buildFlightWidget,
              child: Image.asset(path),
            ),
          ),
        ],
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
                image: AssetImage(path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
