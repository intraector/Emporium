import 'package:flutter/material.dart';

//Create a transition that fades in the new view, while fading out a white background
class WhitePageRoute extends PageRouteBuilder {
  WhitePageRoute({required this.enterPage})
      : super(
            transitionDuration: const Duration(milliseconds: 1700),
            reverseTransitionDuration: const Duration(milliseconds: 1000),
            pageBuilder: (context, animation, secondaryAnimation) => enterPage,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var fadeIn = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  curve: const Interval(.1, 1),
                  parent: animation,
                ),
              );
              var fadeOut = Tween<double>(begin: 0, end: 1).animate(
                CurvedAnimation(
                  curve: const Interval(0, 0.5),
                  parent: animation,
                ),
              );
              return Stack(
                children: <Widget>[
                  FadeTransition(
                    opacity: fadeOut,
                    child: Container(color: Colors.black),
                  ),
                  FadeTransition(
                    opacity: fadeIn,
                    child: child,
                  )
                ],
              );
            });

  final Widget enterPage;
}
