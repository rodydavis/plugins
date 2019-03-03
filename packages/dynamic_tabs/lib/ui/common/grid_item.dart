import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/classes/tab.dart';

class GridTabItem extends StatelessWidget {
  const GridTabItem({
    Key key,
    @required this.tab,
    this.active = true,
    this.adaptive = false,
    this.draggable = false,
  }) : super(key: key);

  final DynamicTab tab;
  final bool active;
  final bool draggable;
  final bool adaptive;

  @override
  Widget build(BuildContext context) {
    final Icon _icon = tab.tab.icon;
    final Text _title = tab.tab.title;
    if (draggable) {
      return Draggable(
        feedback: DefaultTextStyle(
            style: adaptive && Platform.isIOS
                ? CupertinoTheme.of(context).textTheme.textStyle
                : Theme.of(context).textTheme.title,
            child: Container(
              width: 120.0,
              height: 80.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(
                    _icon.icon,
                    size: 35.0,
                  ),
                  AutoSizeText(
                    _title.data,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            )),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              _icon.icon,
              color: active ? null : Colors.grey,
            ),
            Text(
              _title.data,
              style: active ? null : TextStyle(color: Colors.grey),
            ),
          ],
        ),
        data: tab.tag,
      );
    }

    if (!active) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            _icon.icon,
            color: Colors.grey,
          ),
          Text(
            _title.data,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _icon,
        _title,
      ],
    );
  }
}
