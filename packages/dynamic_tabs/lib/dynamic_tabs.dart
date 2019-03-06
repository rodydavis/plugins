import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/classes/tab.dart';
import 'ui/more_screen.dart';
export 'data/classes/tab.dart';

class DynamicTabScaffold extends StatefulWidget {
  DynamicTabScaffold({
    @required this.tabs,
    this.backgroundColor,
    this.persistIndex = false,
    this.iconSize,
    this.maxTabs = 4,
    this.tag = "",
    this.type = BottomNavigationBarType.fixed,
  })  : adaptive = false,
        routes = null,
        assert(tabs != null),
        assert(tabs.length >= 2);

  DynamicTabScaffold.adaptive({
    @required this.tabs,
    this.backgroundColor,
    this.persistIndex = false,
    this.maxTabs = 4,
    this.tag = "",
    @required this.routes,
  })  : adaptive = true,
        type = null,
        iconSize = null,
        assert(tabs != null),
        assert(tabs.length >= 2);

  final List<DynamicTab> tabs;
  final bool adaptive;
  final Color backgroundColor;
  final bool persistIndex;
  final int maxTabs;
  final Map<String, WidgetBuilder> routes;

  // Unique Tag for each set of dynamic tabs
  final String tag;

  // Material Only
  final double iconSize;
  // final Color fixedColor;
  final BottomNavigationBarType type;
  // final Color unselectedItemColor;

  @override
  _DynamicTabScaffoldState createState() => _DynamicTabScaffoldState();
}

class _DynamicTabScaffoldState extends State<DynamicTabScaffold> {
  int _currentIndex = 0;

  SharedPreferences _prefs;

  List<DynamicTab> _items;

  @override
  void initState() {
    _items = widget.tabs;
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      _loadSavedTabs();
      if (widget.persistIndex) _loadIndex();
    });
    super.initState();
  }

  void _loadSavedTabs() {
    List<String> _tabs = _prefs.getStringList(tabsKey);
    if (_tabs != null && _tabs.isNotEmpty) {
      List<DynamicTab> _newOrder = [];
      for (var item in _tabs) {
        _newOrder.add(_items.firstWhere((t) => t.tag == item));
      }
      setState(() {
        _items = _newOrder;
      });
    } else {
      _saveNewTabs();
    }
  }

  void _saveNewTabs() {
    _prefs.setStringList(tabsKey, _items.map((t) => t.tag).toList());
  }

  void _loadIndex() {
    int _index = _prefs.getInt(navKey);
    if (_index > widget.maxTabs) {
      _index = 0;
      _saveIndex();
    }
    if (_index != null) {
      setState(() {
        _currentIndex = _index;
      });
    } else {
      _saveIndex();
    }
  }

  void _saveIndex() {
    _prefs.setInt(navKey, _currentIndex);
  }

  String get tabsKey => "${(widget?.tag ?? "") + "_"}bottom_tabs";
  String get navKey => "${(widget?.tag ?? "") + "_"}nav_index";

  @override
  Widget build(BuildContext context) {
    if (widget.adaptive && Platform.isIOS) {
      return CupertinoTabScaffold(
        tabBuilder: (BuildContext context, int index) {
          return _getBody(context);
        },
        tabBar: CupertinoTabBar(
          items: _showEditTab
              ? (_items.take(widget.maxTabs).toList().map((t) => t.tab).toList()
                ..add(BottomNavigationBarItem(
                  title: Text("More"),
                  icon: Icon(Icons.more_horiz),
                )))
              : _items.map((t) => t.tab).toList(),
          currentIndex: _currentIndex,
          onTap: _tabChanged,
          backgroundColor: widget?.backgroundColor,
        ),
      );
    }

    return Scaffold(
      body: _getBody(context),
      bottomNavigationBar: BottomNavigationBar(
        items: _showEditTab
            ? (_items.take(widget.maxTabs).toList().map((t) => t.tab).toList()
              ..add(BottomNavigationBarItem(
                title: Text("More"),
                icon: Icon(Icons.more_horiz),
              )))
            : _items.map((t) => t.tab).toList(),
        currentIndex: _currentIndex,
        onTap: _tabChanged,
        fixedColor: widget?.backgroundColor ?? Theme.of(context).primaryColor,
        type: widget?.type,
        // unselectedItemColor: widget?.unselectedItemColor ?? Colors.grey,
      ),
    );
  }

  void _tabChanged(int index) {
    print("Index: $index");
    setState(() {
      _currentIndex = index;
    });
    if (widget.persistIndex) _saveIndex();
  }

  Widget _getBody(BuildContext context) {
    if (_showEditTab && _moreTab) {
      if (widget.adaptive && Platform.isIOS) {
        return CupertinoTabView(
          routes: widget.routes,
          builder: (BuildContext context) => MoreTab(
                maxTabs: widget.maxTabs,
                adaptive: widget.adaptive,
                tabs: _items,
                tabsChanged: (List<DynamicTab> tabs) {
                  setState(() {
                    _items = tabs;
                  });
                  _saveNewTabs();
                },
              ),
        );
      }
      return MoreTab(
        maxTabs: widget.maxTabs,
        adaptive: widget.adaptive,
        tabs: _items,
        tabsChanged: (List<DynamicTab> tabs) {
          setState(() {
            _items = tabs;
          });
          _saveNewTabs();
        },
      );
    }

    if (widget.adaptive && Platform.isIOS) {
      return CupertinoTabView(
        routes: widget.routes,
        builder: (BuildContext context) => _items[_currentIndex].child,
      );
    }

    return _items[_currentIndex].child;
  }

  bool get _moreTab => _currentIndex == widget.maxTabs;

  bool get _showEditTab => _items.length > widget.maxTabs;
}
