import 'dart:io';

import 'package:dynamic_tabs/data/classes/tab.dart';
import 'package:dynamic_tabs/ui/more_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

export 'package:dynamic_tabs/data/classes/tab.dart';

class DynamicTabScaffold extends StatefulWidget {
  DynamicTabScaffold({
    @required this.tabs,
    this.backgroundColor,
  })  : adaptive = false,
        androidNav = null,
        iosNav = null,
        androidScaffold = null,
        iosScaffold = null,
        assert(tabs != null),
        assert(tabs.length >= 2);

  DynamicTabScaffold.adaptive({
    @required this.tabs,
    this.backgroundColor,
    this.androidNav,
    this.iosScaffold,
    this.androidScaffold,
    this.iosNav,
  })  : adaptive = true,
        assert(tabs != null),
        assert(tabs.length >= 2);

  final List<DynamicTab> tabs;
  final bool adaptive;
  final Color backgroundColor;
  final CupertinoPageScaffoldData iosScaffold;
  final MaterialScaffoldData androidScaffold;
  final MaterialNavBarData androidNav;
  final CupertinoTabBarData iosNav;

  @override
  _DynamicTabScaffoldState createState() => _DynamicTabScaffoldState();
}

class _DynamicTabScaffoldState extends State<DynamicTabScaffold> {
  int _currentIndex = 0;

  List<BottomNavigationBarItem> _items;

  @override
  void initState() {
    _items = widget.tabs.take(4).toList().map((t) => t.tab).toList()
      ..add(BottomNavigationBarItem(
        title: Text("More"),
        icon: Icon(Icons.more_horiz),
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adaptive) {
      return PlatformScaffold(
        body: _getBody(context),
        bottomNavBar: PlatformNavBar(
          items: _items,
          currentIndex: _currentIndex,
          itemChanged: _tabChanged,
          ios: widget?.iosNav == null
              ? null
              : (BuildContext context) => widget.iosNav,
          android: widget?.androidNav == null
              ? null
              : (BuildContext context) => widget.androidNav,
          backgroundColor: widget?.backgroundColor,
        ),
      );
    }

    return Scaffold(
      body: _getBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: _tabChanged,
        backgroundColor: widget?.backgroundColor,
      ),
    );
  }

  void _tabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getBody(BuildContext context) {
    if (_editTab) {
      return CupertinoTabView(
        builder: (BuildContext context) => MoreTab(
              adaptive: widget.adaptive,
              tabs: widget.tabs,
            ),
      );
    }

    if (widget.adaptive && Platform.isIOS)
      return CupertinoTabView(
        builder: (BuildContext context) => widget.tabs[_currentIndex].child,
      );

    return widget.tabs[_currentIndex].child;
  }

  bool get _editTab =>
      _currentIndex == 4 ||
      (widget.tabs.length < 4 && _currentIndex == widget.tabs.length + 1);
}
