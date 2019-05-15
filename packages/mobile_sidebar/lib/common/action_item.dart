import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'menu_item.dart';

class GridActionItem extends StatelessWidget {
  const GridActionItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final MenuItem item;

  @override
  Widget build(BuildContext context) {
    final _brightness = Theme.of(context).brightness;
    return LayoutBuilder(
        builder: (_, dimns) => Column(
              children: <Widget>[
                Expanded(
                  child: Material(
                      color: item.color,
                      shape: CircleBorder(),
                      child: Container(
                        padding: EdgeInsets.all(16.0),
                        child: dimns.maxWidth < 75
                            ? null
                            : Icon(
                                item.icon,
                                color: Colors.white,
                                size: dimns.maxWidth * .3,
                              ),
                      )),
                ),
                if (dimns.maxWidth > 100) ...[
                  Container(
                    padding: EdgeInsets.only(top: 16.0),
                    child: AutoSizeText(item.title,
                        maxLines: 1,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            color: _brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: dimns.maxWidth * .15)),
                  ),
                ],
                if (item?.subtitle != null && dimns.maxWidth > 120) ...[
                  AutoSizeText(
                    item.subtitle,
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: _brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                      fontSize: dimns.maxWidth * .1,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                  )
                ]
              ],
            ));
  }
}
