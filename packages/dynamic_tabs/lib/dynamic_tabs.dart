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
    this.masterDetailOnMoreTab = false,
    this.breakpoint = 720,
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
    this.masterDetailOnMoreTab = false,
    this.breakpoint = 720,
    this.moreTabAccentColor,
    BottomNavigationBarType materialType = BottomNavigationBarType.fixed,
    double materialIconSize,
    this.selectedColor,
  })  : adaptive = true,
        type = materialType,
        iconSize = materialIconSize,
        assert(tabs != null),
        assert(tabs.length >= 2);

  final bool adaptive;
  final Color backgroundColor;
  final double breakpoint;
  // Material Only
  final double iconSize;

  final bool masterDetailOnMoreTab;
  final int maxTabs;
  final Color moreTabAccentColor;
  // final Color unselectedItemColor;

  final Color moreTabPrimaryColor;

  final bool persistIndex;
  final Map<String, WidgetBuilder> routes;
  final Color selectedColor;
  final List<DynamicTab> tabs;
  // Unique Tag for each set of dynamic tabs
  final String tag;

  // final Color fixedColor;
  final BottomNavigationBarType type;

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
              breakpoint: breakpoint,
              masterDetailOnMoreTab: masterDetailOnMoreTab,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            );
          }

          if (adaptive &&
              (Platform.isMacOS || Platform.isLinux || Platform.isWindows)) {
            return new DesktopView(
              routes: routes,
              breakpoint: breakpoint,
              masterDetailOnMoreTab: masterDetailOnMoreTab,
              adaptive: adaptive,
              moreTabAccentColor: moreTabAccentColor,
              moreTabPrimaryColor: moreTabPrimaryColor,
            );
          }

          return new MaterialView(
            routes: routes,
            breakpoint: breakpoint,
            masterDetailOnMoreTab: masterDetailOnMoreTab,
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
    @required this.breakpoint,
    @required this.masterDetailOnMoreTab,
  }) : super(key: key);

  final bool adaptive;
  final Color backgroundColor;
  final int maxTabs;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;
  final Map routes;
  final Color selectedColor;
  final BottomNavigationBarType type;
  final bool masterDetailOnMoreTab;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => Scaffold(
            body: ContentView(
              routes: routes,
              adaptive: adaptive,
              breakpoint: breakpoint,
              masterDetailOnMoreTab: masterDetailOnMoreTab,
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
              currentIndex: model.adjustedIndex,
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
    @required this.breakpoint,
    @required this.masterDetailOnMoreTab,
  }) : super(key: key);

  final bool adaptive;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;
  final Map routes;
  final bool masterDetailOnMoreTab;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => Scaffold(
            body: ContentView(
              routes: routes,
              adaptive: adaptive,
              breakpoint: breakpoint,
              masterDetailOnMoreTab: masterDetailOnMoreTab,
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
    @required this.breakpoint,
    @required this.masterDetailOnMoreTab,
  }) : super(key: key);

  final bool adaptive;
  final Color backgroundColor;
  final int maxTabs;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;
  final Map<String, WidgetBuilder> routes;
  final Color selectedColor;
  final bool masterDetailOnMoreTab;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return Consumer<TabState>(
      builder: (context, model, child) => CupertinoTabScaffold(
            tabBuilder: (BuildContext context, int index) {
              return ContentView(
                routes: routes,
                adaptive: adaptive,
                breakpoint: breakpoint,
                masterDetailOnMoreTab: masterDetailOnMoreTab,
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
              currentIndex: model.adjustedIndex,
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
    @required this.breakpoint,
    @required this.masterDetailOnMoreTab,
  });

  final bool adaptive;
  final Color moreTabAccentColor;
  final Color moreTabPrimaryColor;
  final Map<String, WidgetBuilder> routes;
  final bool masterDetailOnMoreTab;
  final double breakpoint;

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
              builder: (BuildContext context) {
                if (masterDetailOnMoreTab) {
                  return MoreTab.fluid(
                    tabState: model,
                    breakpoint: breakpoint,
                    adaptive: adaptive,
                    primaryColor: moreTabPrimaryColor,
                    accentColor: moreTabAccentColor,
                    navigator: Navigator.of(context),
                  );
                }
                return MoreTab(
                  tabState: model,
                  adaptive: adaptive,
                  primaryColor: moreTabPrimaryColor,
                  accentColor: moreTabAccentColor,
                  navigator: Navigator.of(context),
                );
              },
            );
          }
          if (masterDetailOnMoreTab) {
            return MoreTab.fluid(
              primaryColor: moreTabPrimaryColor,
              accentColor: moreTabAccentColor,
              adaptive: adaptive,
              breakpoint: breakpoint,
              tabState: model,
              navigator: Navigator.of(context),
            );
          }
          return MoreTab(
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
