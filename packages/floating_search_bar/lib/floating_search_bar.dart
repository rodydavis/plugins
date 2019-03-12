import 'dart:async';

import 'package:floating_search_bar/ui/sliver_search_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class FloatingSearchBar extends StatelessWidget {
  const FloatingSearchBar({
    this.body,
    this.drawer,
    this.trailing,
    this.leading,
  });

  final Widget leading, trailing, body, drawer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverSearchBar(
            leading: leading,
            floating: true,
          ),
          SliverToBoxAdapter(child: body ?? Container()),
        ],
      ),
    );
  }
}
