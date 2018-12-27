import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../native_widgets.dart';

class CupertinoAvatarListTile extends StatelessWidget {
  const CupertinoAvatarListTile({
    @required this.title,
    this.subtitle,
    this.actions,
    this.avatar,
  });

  final Widget avatar;
  final String title, subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets = <Widget>[
      Container(
        height: 60.0,
        width: 60.0,
        child: avatar,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: subtitle == null
              ? NativeText(title, type: NativeTextTheme.title)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    NativeText(title, type: NativeTextTheme.title),
                    const Padding(padding: EdgeInsets.only(top: 8.0)),
                    NativeText(subtitle, type: NativeTextTheme.subtitle),
                  ],
                ),
        ),
      ),
    ];

    // final Widget row = GestureDetector(
    //   behavior: HitTestBehavior.opaque,
    //   onTap: onTap,
    //   onLongPress: onLongPressed,
    //   child: SafeArea(
    //     top: false,
    //     bottom: false,
    //     child: Container(
    //       color: selected ? Colors.grey[400] : Colors.transparent,
    //       padding: const EdgeInsets.only(
    //           left: 16.0, top: 8.0, bottom: 8.0, right: 8.0),
    //       child: Row(children: _widgets..addAll(actions ?? <Widget>[])),
    //     ),
    //   ),
    // );

    final Widget row = Row(children: _widgets..addAll(actions ?? <Widget>[]));

    return row;
  }
}
