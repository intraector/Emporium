import 'package:emporium/home.dart';
import 'package:emporium/views/view_settings.dart';
import 'package:flutter/material.dart';

class BottomTabBarMaterial extends StatelessWidget {
  BottomTabBarMaterial({required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    Widget _home;
    Widget _settings;
    final _inactiveColor = Theme.of(context).primaryColor;
    final _disabledColor = Theme.of(context).backgroundColor;
    final double _iconSize = 26;

    //----------------------------------------_home
    _home = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.home),
          iconSize: _iconSize,
          disabledColor: _inactiveColor,
          color: _disabledColor,
          onPressed: index == 0
              ? null
              : () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewHome();
                      },
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
    _settings = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.settings),
          iconSize: _iconSize,
          disabledColor: _inactiveColor,
          color: _disabledColor,
          onPressed: index == 1
              ? null
              : () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ViewSettings();
                      },
                    ),
                  ),
        ),
        // Text(
        //   'Settings',
        //   style: TextStyle(color: _path == Paths.settings ? _inactiveColor : _disabledColor),
        // ),
      ],
    );

    var _list = [_home, _settings];

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _list,
      ),
    );
  }
}
