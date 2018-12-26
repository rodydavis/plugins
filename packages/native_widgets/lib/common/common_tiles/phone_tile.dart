import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../native_widgets.dart';

class CupertinoPhoneListTile extends StatelessWidget {
  final String subtitle, title;
  final List<Widget> actions;
  final NativeIcon icon;
  final VoidCallback onTap, onLongPressed;
  final bool lastItem, selected, hideLeadingIcon;

  const CupertinoPhoneListTile({
    this.actions,
    this.onLongPressed,
    this.onTap,
    this.subtitle,
    @required this.title,
    this.icon,
    this.lastItem = false,
    this.selected = false,
    this.hideLeadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget row;
    if (subtitle == null) {
      row = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          onLongPress: onLongPressed,
          child: Container(
            color: selected ? Colors.grey[400] : Colors.transparent,
            height: 40.0,
            padding: EdgeInsets.only(top: subtitle == null ? 0.0 : 9.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: hideLeadingIcon ? 12.0 : 38.0,
                  child: icon != null && !hideLeadingIcon
                      ? Align(
                          alignment: Alignment.center,
                          child: icon?.iosIcon != null
                              ? Icon(
                                  icon.iosIcon,
                                  color: CupertinoColors.inactiveGray,
                                  size: 18.0,
                                )
                              : icon,
                        )
                      : null,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 1.0, bottom: 0.0, right: 10.0),
                    child: Row(
                        children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            NativeText(title, type: NativeTextTheme.title)
                          ],
                        ),
                      ),
                    ]..addAll(actions ?? <Widget>[])),
                  ),
                ),
              ],
            ),
          ));
    } else {
      row = GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          onLongPress: onLongPressed,
          child: Container(
            color: selected ? Colors.grey[400] : Colors.transparent,
            height: 60.0,
            padding: const EdgeInsets.only(top: 9.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: hideLeadingIcon ? 12.0 : 38.0,
                  child: icon != null && !hideLeadingIcon
                      ? Align(
                          alignment: Alignment.topCenter,
                          child: icon?.iosIcon != null
                              ? Icon(
                                  icon.iosIcon,
                                  color: CupertinoColors.inactiveGray,
                                  size: 18.0,
                                )
                              : icon,
                        )
                      : null,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 1.0, bottom: 9.0, right: 10.0),
                    child: Row(
                        children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            NativeText(title, type: NativeTextTheme.title),
                            NativeText(subtitle,
                                type: NativeTextTheme.subtitle),
                          ],
                        ),
                      ),
                    ]..addAll(actions ?? <Widget>[])),
                  ),
                ),
              ],
            ),
          ));
    }

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Container(
          height: 1.0,
          color: const Color(0xFFD9D9D9),
        ),
      ],
    );
  }
}
