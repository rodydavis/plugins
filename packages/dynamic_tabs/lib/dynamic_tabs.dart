import 'dart:io';

import 'package:dynamic_tabs/data/classes/tab.dart';
import 'package:dynamic_tabs/ui/more_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:dynamic_tabs/data/classes/tab.dart';

class DynamicTabScaffold extends StatefulWidget {
  DynamicTabScaffold({
    @required this.tabs,
    this.backgroundColor,
    this.persistIndex = false,
    this.iconSize,
    this.fixedColor,
    this.type,
    this.unselectedItemColor,
  })  : adaptive = false,
        assert(tabs != null),
        assert(tabs.length >= 2);

  DynamicTabScaffold.adaptive({
    @required this.tabs,
    this.backgroundColor,
    this.persistIndex = false,
  })  : adaptive = true,
        type = null,
        fixedColor = null,
        iconSize = null,
        unselectedItemColor = null,
        assert(tabs != null),
        assert(tabs.length >= 2);

  final List<DynamicTab> tabs;
  final bool adaptive;
  final Color backgroundColor;
  final bool persistIndex;

  // Material Only
  final double iconSize;
  final Color fixedColor;
  final BottomNavigationBarType type;
  final Color unselectedItemColor;

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
    List<String> _tabs = _prefs.getStringList("bottom_tabs");
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
    _prefs.setStringList("bottom_tabs", _items.map((t) => t.tag).toList());
  }

  void _loadIndex() {
    int _index = _prefs.getInt("nav_index");
    if (_index != null) {
      setState(() {
        _currentIndex = _index;
      });
    } else {
      _saveIndex();
    }
  }

  void _saveIndex() {
    _prefs.setInt("nav_index", _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.adaptive) {
      return PlatformScaffold(
        body: _getBody(context),
        bottomNavBar: PlatformNavBar(
          items: _items.length > 5
              ? (_items.take(4).toList().map((t) => t.tab).toList()
                ..add(BottomNavigationBarItem(
                  title: Text("More"),
                  icon: Icon(Icons.more_horiz),
                )))
              : _items.map((t) => t.tab).toList(),
          currentIndex: _currentIndex,
          itemChanged: _tabChanged,
          backgroundColor: widget?.backgroundColor,
        ),
      );
    }

    return Scaffold(
      body: _getBody(context),
      bottomNavigationBar: BottomNavigationBar(
          items: _showEditTab
              ? (_items.take(4).toList().map((t) => t.tab).toList()
                ..add(BottomNavigationBarItem(
                  title: Text("More"),
                  icon: Icon(Icons.more_horiz),
                )))
              : _items.map((t) => t.tab).toList(),
          currentIndex: _currentIndex,
          onTap: _tabChanged,
          backgroundColor: widget?.backgroundColor,
          fixedColor: widget?.fixedColor ?? Theme.of(context).primaryColor,
          type: widget?.type,
          unselectedItemColor: widget?.unselectedItemColor ?? Colors.grey),
    );
  }

  void _tabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (widget.persistIndex) _saveIndex();
  }

  Widget _getBody(BuildContext context) {
    if (_showEditTab && _editTab) {
      if (widget.adaptive && Platform.isIOS) {
        return CupertinoTabView(
          builder: (BuildContext context) => MoreTab(
                adaptive: widget.adaptive,
                tabs: widget.tabs,
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
        adaptive: widget.adaptive,
        tabs: widget.tabs,
        tabsChanged: (List<DynamicTab> tabs) {
          setState(() {
            _items = tabs;
          });
          _saveNewTabs();
        },
      );
    }

    if (widget.adaptive && Platform.isIOS)
      return CupertinoTabView(
        builder: (BuildContext context) => CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: widget?.tabs[_currentIndex]?.tab?.title,
                trailing: widget?.tabs[_currentIndex]?.trailingAction,
              ),
              child: widget.tabs[_currentIndex].child,
            ),
      );

    return Scaffold(
      appBar: AppBar(
        title: widget?.tabs[_currentIndex]?.tab?.title,
        actions: widget?.tabs[_currentIndex]?.trailingAction == null
            ? null
            : <Widget>[]
          ..add(widget.tabs[_currentIndex].trailingAction),
      ),
      body: widget.tabs[_currentIndex].child,
    );
  }

  bool get _editTab =>
      _currentIndex == 4 ||
      (widget.tabs.length < 4 && _currentIndex == widget.tabs.length + 1);

  bool get _showEditTab => _items.length > 5;
}
