import 'package:flutter/material.dart';

class DynamicTab {
  const DynamicTab({
    @required this.child,
    @required this.tab,
    @required this.tag,
  });

  final Widget child;
  final BottomNavigationBarItem tab;

  /// Uniquie Tag used for storing the tab order on the device
  final String tag;
}
