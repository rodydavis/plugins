import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum CupertinoTextTheme { title, subtitle, detail, custom }

class CupertinoText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final int maxLines;
  final CupertinoTextTheme type;

  const CupertinoText(
    this.data, {
    Key key,
    this.style,
    this.maxLines = 1,
    this.type = CupertinoTextTheme.detail,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case CupertinoTextTheme.title:
        return Text(
          data,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: -0.18,
          ),
        );
      case CupertinoTextTheme.subtitle:
        return Text(
          data,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15.0,
            letterSpacing: -0.24,
            color: CupertinoColors.inactiveGray,
          ),
        );
      case CupertinoTextTheme.detail:
        return Text(
          data,
          style: const TextStyle(
            color: CupertinoColors.inactiveGray,
            fontSize: 15.0,
            letterSpacing: -0.41,
          ),
        );
      case CupertinoTextTheme.custom:
        return Text(
          data,
          style: style ??
              const TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 15.0,
                letterSpacing: -0.41,
              ),
        );
    }
    return Container();
  }
}
