import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class DynamicTab {
  const DynamicTab({
    @required this.body,
    @required this.tab,
    @required this.tag,
    this.appBar,
  });

  const DynamicTab.adaptive({
    @required this.body,
    @required this.tab,
    @required this.tag,
    PlatformAppBar appBar,
  }) : appBar = appBar;

  final Widget appBar;
  final Widget body;
  final BottomNavigationBarItem tab;

  /// Uniquie Tag used for storing the tab order on the device
  final String tag;
}

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
        appBar: _getAppBar(context),
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
      appBar: _getAppBar(context),
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

  Widget _getAppBar(BuildContext context) {
    if (_editTab) {
      if (widget.adaptive)
        return PlatformAppBar(
          title: Text("More"),
        );
      return AppBar(
        title: Text("More"),
      );
    }
    return widget.tabs[_currentIndex].appBar;
  }

  Widget _getBody(BuildContext context) {
    if (_editTab) {
      final _extraItems = widget.tabs.getRange(4, widget.tabs.length).toList();
      return Container(
        child: ListView.builder(
          itemCount: _extraItems.length,
          itemBuilder: (BuildContext context, int index) {
            final i = _extraItems[index];
            return ListTile(
              leading: i.tab.icon,
              title: i.tab.title,
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => widget.adaptive
                            ? PlatformScaffold(
                                appBar: i.appBar,
                                body: i.body,
                              )
                            : Scaffold(
                                appBar: i.appBar,
                                body: i.body,
                              )),
                  ),
            );
          },
        ),
      );
    }
    return widget.tabs[_currentIndex].body;
  }

  // List<BottomNavigationBarItem> _getTabs(BuildContext context) {
  //   if (widget.tabs.length > 4)
  //     widget.tabs.map((t) => t.tab).toList()
  //       ..add(BottomNavigationBarItem(
  //         title: Text("More"),
  //         icon: Icon(Icons.more_horiz),
  //       ));
  //   return widget.tabs.map((t) => t.tab).toList();
  // }

  bool get _editTab =>
      _currentIndex == 4 ||
      (widget.tabs.length < 4 && _currentIndex == widget.tabs.length + 1);
}
