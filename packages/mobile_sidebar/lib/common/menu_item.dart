import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    @required this.icon,
    @required this.subtitle,
    @required this.title,
    @required this.child,
    @required this.color,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Color color;

  void push(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _MobileView(item: this),
        ),
      );
}

class _MobileView extends StatelessWidget {
  const _MobileView({
    Key key,
    this.appBar = false,
    @required this.item,
  }) : super(key: key);

  final MenuItem item;
  final bool appBar;

  @override
  Widget build(BuildContext context) {
    if (appBar) {
      return Scaffold(
        appBar: AppBar(
          title: Text(item.title),
        ),
        body: item.child,
      );
    }

    return item.child;
  }
}
