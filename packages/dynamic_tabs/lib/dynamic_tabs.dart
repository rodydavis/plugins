import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

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
    this.moreTabPrimaryColor,
    this.moreTabAccentColor,
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
    this.moreTabPrimaryColor,
    this.moreTabAccentColor,
    BottomNavigationBarType materialType = BottomNavigationBarType.fixed,
    double materialIconSize,
  })  : adaptive = true,
        type = materialType,
        iconSize = materialIconSize,
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

  final Color moreTabPrimaryColor;
  final Color moreTabAccentColor;

  @override
  _DynamicTabScaffoldState createState() => _DynamicTabScaffoldState();
}

class _DynamicTabScaffoldState extends State<DynamicTabScaffold> {
  int _currentIndex = 0;
  LocalStorage _storage;
  List<DynamicTab> _items;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(DynamicTabScaffold oldWidget) {
    if (oldWidget.tabs != widget.tabs) {
      init();
    }
    super.didUpdateWidget(oldWidget);
  }

  void init() {
    _items = widget.tabs;
    _storage = new LocalStorage((widget?.tag ?? "app_dynamic_tabs"));
    _storage.ready.then((value) {
      _loadSavedTabs();
      if (widget.persistIndex) _loadIndex();
    });
  }

  void _loadSavedTabs() async {
    List<String> _list = [];
    try {
      final _data = _storage.getItem(tabsKey);
      if (_data != null) {
        _list = List.from(_data);
      }
    } catch (e) {
      print("Couldn't read file: $e");
    }
    List<String> _tabs = _list ?? [];
    // print("List: ${widget?.tabs?.length ?? 0} $_tabs");
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

  void _saveNewTabs() async {
    final _list = _items.map((t) => t.tag).toList();
    await _storage.setItem(tabsKey, _list);
  }

  void _loadIndex() {
    int _index = _storage.getItem(navKey);

    if (_index != null) {
      if (_index > widget.maxTabs) {
        _index = 0;
        _saveIndex();
      }
      setState(() {
        _currentIndex = _index;
      });
    } else {
      _saveIndex();
    }
  }

  void _saveIndex() {
    _storage.setItem(navKey, _currentIndex);
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

    if (widget.adaptive && _isDesktop()) {
      return Scaffold(
        body: _getBody(context),
        drawer: Drawer(
          child: Container(
            child: SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < _items.length; i++) ...[
                        ListTile(
                          selected: i == _currentIndex,
                          leading: _items[i].tab.icon,
                          title: _items[i].tab.title,
                          onTap: () {
                            if (mounted)
                              setState(() {
                                _tabChanged(i);
                              });
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
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

  bool _isDesktop() {
    return Platform.isMacOS || Platform.isLinux || Platform.isWindows;
  }

  void _tabChanged(int index) {
    print("Index: $index");
    setState(() {
      _currentIndex = index;
    });
    if (widget.persistIndex) _saveIndex();
  }

  Widget _getBody(BuildContext context) {
    if (_showEditTab && _moreTab && !_isDesktop()) {
      if (widget.adaptive && Platform.isIOS) {
        return CupertinoTabView(
          routes: widget.routes,
          builder: (BuildContext context) => MoreTab(
                tag: widget?.tag ?? "",
                maxTabs: widget.maxTabs,
                adaptive: widget.adaptive,
                currentIndex: _currentIndex,
                persitIndex: widget.persistIndex,
                primaryColor: widget?.moreTabPrimaryColor,
                accentColor: widget?.moreTabAccentColor,
                navigator: Navigator.of(context),
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
        primaryColor: widget?.moreTabPrimaryColor,
        accentColor: widget?.moreTabAccentColor,
        maxTabs: widget.maxTabs,
        currentIndex: _currentIndex,
        adaptive: widget.adaptive,
        tag: widget?.tag ?? "",
        persitIndex: widget.persistIndex,
        navigator: Navigator.of(context),
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
        builder: (BuildContext context) =>
            Material(child: _items[_currentIndex].child),
      );
    }

    return _items[_currentIndex].child;
  }

  bool get _moreTab => _currentIndex == widget.maxTabs;

  bool get _showEditTab => _items.length > widget.maxTabs;
}
