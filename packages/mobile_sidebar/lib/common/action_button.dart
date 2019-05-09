import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class ActionButton extends StatelessWidget {
  final String title, subtitle;
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double textScaleFactor;

  ActionButton({
    @required this.title,
    this.subtitle,
    this.iconData = Icons.add,
    this.color = Colors.amber,
    this.onTap,
    this.textScaleFactor = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final _brightness = Theme.of(context).brightness;
    return InkWell(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                    color: color,
                    shape: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(iconData, color: Colors.white, size: 20),
                    )),
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: AutoSizeText(title,
                      maxLines: 1,
                      textScaleFactor: textScaleFactor,
                      style: TextStyle(
                          color: _brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0)),
                ),
                Container(
                  child: subtitle == null
                      ? null
                      : AutoSizeText(
                          subtitle,
                          textScaleFactor: textScaleFactor,
                          style: Theme.of(context).textTheme.subhead.copyWith(
                              color: _brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black87),
                          maxLines: 1,
                        ),
                ),
              ])),
    );
  }
}
