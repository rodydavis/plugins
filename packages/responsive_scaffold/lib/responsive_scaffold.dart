import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResponsiveScaffold extends StatelessWidget {
  ResponsiveScaffold({
    this.tabletBreakpoint = const Size(480.0, 480.0),
  });

  final Size tabletBreakpoint;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    if (_size.width >= tabletBreakpoint.width &&
        _size.height >= tabletBreakpoint.height) {
      // Tablet
      return Container();
    }

    // Mobile
    return Container();
  }
}
