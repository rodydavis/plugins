import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem({
    @required this.icon,
    @required this.subtitle,
    @required this.title,
    @required this.child,
    @required this.color,
    this.actions,
    this.showAppBar = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  final Color color;
  final List<Widget> actions;
  final bool showAppBar;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  void push(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: _buildAppBar(context),
                  body: child,
                )),
      );

  AppBar _buildAppBar(BuildContext context) {
    return showAppBar
        ? AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(title ?? ''),
            actions: <Widget>[if (actions != null) ...actions],
          )
        : null;
  }
}
