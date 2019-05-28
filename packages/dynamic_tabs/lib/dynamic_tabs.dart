import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import 'data/classes/tab.dart';
import 'data/models/index.dart';
import 'ui/more_screen.dart';

export 'data/classes/tab.dart';

class DynamicTabScaffold extends StatelessWidget {
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
    this.selectedColor,
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
    this.selectedColor,
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
  final Color selectedColor;

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
  Widget build(BuildContext context) {
    return ListenableProvider<TabState>(
      builder: (_) =>
          TabState()..init(tag, tabs, max: maxTabs, persist: persistIndex),
      child: Builder(
        builder: (_) {
          if (adaptive && Platform.isIOS) {
            return CupertinoView(
              selectedColor: selectedColor,
              backgroundColor: backgroundColor,
              routes: routes,
              adaptive: adaptive,
              maxTabs: maxTabs,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            );
          }

          if (adaptive &&
              (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
            return new DesktopView(
              routes: routes,
              adaptive: adaptive,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            );
          }

          return new MaterialView(
            routes: routes,
            adaptive: adaptive,
            moreTabAccentColor: moreTabAccentColor,
            moreTabPrimaryColor: moreTabPrimaryColor,
            selectedColor: selectedColor,
            maxTabs: maxTabs,
            backgroundColor: backgroundColor,
            type: type,
          );
        },
      ),
    );
  }
}

class MaterialView extends StatelessWidget {
  const MaterialView({
    Key key,
    @required this.routes,
    @required this.adaptive,
    @required this.moreTabAccentColor,
    @required this.moreTabPrimaryColor,
    @required this.selectedColor,
    @required this.maxTabs,
    @required this.backgroundColor,
    @required this.type,
  }) : super(key: key);

  final Map routes;
  final bool adaptive;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;
  final Color selectedColor;
  final int maxTabs;
  final Color backgroundColor;
  final BottomNavigationBarType type;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => Scaffold(
            body: ContentView(
              routes: routes,
              adaptive: adaptive,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: selectedColor,
              items: model.showEditTab
                  ? (model.mainTabs.map((t) => t.tab).toList()
                    ..add(BottomNavigationBarItem(
                      title: Text("More"),
                      icon: Icon(Icons.more_horiz),
                    )))
                  : model.allTabs.map((t) => t.tab).toList(),
              currentIndex: model.currentIndex,
              onTap: model.changeTab,
              fixedColor: backgroundColor ?? Theme.of(context).primaryColor,
              type: type,
              // unselectedItemColor: unselectedItemColor ?? Colors.grey,
            ),
          ),
    );
  }
}

class DesktopView extends StatelessWidget {
  const DesktopView({
    Key key,
    @required this.routes,
    @required this.adaptive,
    @required this.moreTabAccentColor,
    @required this.moreTabPrimaryColor,
  }) : super(key: key);

  final Map routes;
  final bool adaptive;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => Scaffold(
            body: ContentView(
              routes: routes,
              adaptive: adaptive,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            ),
            drawer: Drawer(
              child: Container(
                child: SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < model.allTabs.length; i++) ...[
                            ListTile(
                              selected: i == model.currentIndex,
                              leading: model.allTabs[i].tab.icon,
                              title: model.allTabs[i].tab.title,
                              onTap: () {
                                model.changeTab(i);
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
          ),
    );
  }
}

class CupertinoView extends StatelessWidget {
  const CupertinoView({
    Key key,
    @required this.selectedColor,
    @required this.maxTabs,
    @required this.backgroundColor,
    @required this.adaptive,
    @required this.routes,
    @required this.moreTabAccentColor,
    @required this.moreTabPrimaryColor,
  }) : super(key: key);

  final Color selectedColor;
  final int maxTabs;
  final Color backgroundColor;
  final bool adaptive;
  final Map<String, WidgetBuilder> routes;
  final Color moreTabPrimaryColor;
  final Color moreTabAccentColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => CupertinoTabScaffold(
            tabBuilder: (BuildContext context, int index) {
              return ContentView(
                routes: routes,
                adaptive: adaptive,
                moreTabAccentColor: moreTabAccentColor,
                moreTabPrimaryColor: moreTabPrimaryColor,
              );
            },
            tabBar: CupertinoTabBar(
              activeColor: selectedColor,
              items: model.showEditTab
                  ? (model.mainTabs.map((t) => t.tab).toList()
                    ..add(BottomNavigationBarItem(
                      title: Text("More"),
                      icon: Icon(Icons.more_horiz),
                    )))
                  : model.allTabs.map((t) => t.tab).toList(),
              currentIndex: model.currentIndex,
              onTap: model.changeTab,
              backgroundColor: backgroundColor,
            ),
          ),
    );
  }
}

class ContentView extends StatelessWidget {
  ContentView({
    @required this.adaptive,
    @required this.routes,
    @required this.moreTabAccentColor,
    @required this.moreTabPrimaryColor,
  });
  final bool adaptive;
  final Map<String, WidgetBuilder> routes;
  final Color moreTabPrimaryColor;
  final Color moreTabAccentColor;
  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) {
        if (model.showEditTab &&
            model.isMoreTab &&
            !(Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
          if (adaptive && Platform.isIOS) {
            return CupertinoTabView(
              routes: routes,
              builder: (BuildContext context) => MoreTab.fluid(
                    tabState: model,
                    adaptive: adaptive,
                    primaryColor: moreTabPrimaryColor,
                    accentColor: moreTabAccentColor,
                    navigator: Navigator.of(context),
                  ),
            );
          }
          return MoreTab.fluid(
            primaryColor: moreTabPrimaryColor,
            accentColor: moreTabAccentColor,
            adaptive: adaptive,
            tabState: model,
            navigator: Navigator.of(context),
          );
        }

        if (adaptive && Platform.isIOS) {
          return CupertinoTabView(
            routes: routes,
            builder: (BuildContext context) => Material(child: model.child),
          );
        }

        return model.child;
      },
    );
  }
}
