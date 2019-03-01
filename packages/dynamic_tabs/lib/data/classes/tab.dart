import 'package:flutter/material.dart';

class DynamicTab {
  const DynamicTab({
    @required this.child,
    @required this.tab,
    @required this.tag,
    this.trailingAction,
    this.title,
  });

  final Widget child;

  /// Widget for the Right Side of the App Bar
  final Widget trailingAction;

  final BottomNavigationBarItem tab;

  final Widget title;

  /// Uniquie Tag used for storing the tab order on the device
  final String tag;
}
