import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/text.dart';

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
              ? CupertinoText(title, type: CupertinoTextTheme.title)
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CupertinoText(title, type: CupertinoTextTheme.title),
                    CupertinoText(subtitle, type: CupertinoTextTheme.subtitle),
                  ],
                ),
        ),
      ),
    ];

    final Widget row = Container(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: _widgets..addAll(actions ?? <Widget>[]),
      ),
    );

    return row;
  }
}
