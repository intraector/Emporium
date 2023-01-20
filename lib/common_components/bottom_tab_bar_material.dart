import 'package:emporium/home.dart';
import 'package:emporium/views/screen_settings.dart';
import 'package:flutter/material.dart';

class BottomTabBarMaterial extends StatelessWidget {
  const BottomTabBarMaterial({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget home;
    Widget settings;
    final inactiveColor = Theme.of(context).primaryColor;
    final disabledColor = Theme.of(context).backgroundColor;
    const double iconSize = 26;

    //----------------------------------------_home
    home = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.home),
          iconSize: iconSize,
          disabledColor: inactiveColor,
          color: disabledColor,
          onPressed: index == 0
              ? null
              : () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => ScreenHome(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
        ),
        // Text(
        //   'Main',
        //   style: TextStyle(color: _path == Paths.home ? _inactiveColor : _disabledColor),
        // )
      ],
    );

    //----------------------------------------_settings
    settings = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.settings),
          iconSize: iconSize,
          disabledColor: inactiveColor,
          color: disabledColor,
          onPressed: index == 1
              ? null
              : () => Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, _, __) => const ScreenSettings(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                  ),
        ),
        // Text(
        //   'Settings',
        //   style: TextStyle(color: _path == Paths.settings ? _inactiveColor : _disabledColor),
        // ),
      ],
    );

    var list = [home, settings];

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: list,
      ),
    );
  }
}
