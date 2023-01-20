import 'package:flutter/material.dart';

class BackgroundPicture extends StatelessWidget {
  BackgroundPicture({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(path),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
