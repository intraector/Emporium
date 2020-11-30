import 'package:Emporium/_constants/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabBarMaterial extends StatelessWidget {
  BottomTabBarMaterial(this._path);
  final String _path;

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
          icon: Icon(CupertinoIcons.home),
          iconSize: _iconSize,
          disabledColor: _inactiveColor,
          color: _disabledColor,
          onPressed: _path == Paths.home ? null : () => Routes.sailor.navigate(Paths.home),
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
          onPressed: _path == Paths.settings ? null : () => Routes.sailor.navigate(Paths.settings),
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
