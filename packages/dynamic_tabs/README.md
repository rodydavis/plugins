# dynamic_tabs

A Flutter plugin for letting the user editing the bottom tabs like the Curpertino iTunes App.

## Getting Started

* Set `persistIndex` to `true` for saving the index of the current tab to disk, everytime the app launches it will open the last tab opened
* Tags must be set for each item and must be unique
* There are 2 Modes `DynamicTabScaffold.adaptive` and `DynamicTabScaffold`. The latter just show material
* When using `adaptive` mode the iOS Platform will be wrapped in a CupertinoTabBar and CurpertinoTabView, this means that the navigation can be perserved per tab and that the nav bar will be shown still on push. On Android it will push the whole screen
* This widget allows you to use a stateless widget for navigation
* This supports Dark Mode
* If there are more than 5 Tabs there will be a 5th Tab Created Call "More" and it will show a list of the remaining tabs
* On the edit screen the user can reorder that tabs to the nav bar as they wish, this will also be saved to disk
* The App Bars for navigation will be created from the Bottom Navbar Titles

``` dart
import 'package:flutter/material.dart';

import 'package:dynamic_tabs/dynamic_tabs.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicTabScaffold.adaptive(
      persistIndex: true,
      tabs: <DynamicTab>[
        DynamicTab(
          child: Container(
            color: Colors.redAccent,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Info"),
            icon: Icon(Icons.info),
          ),
          tag: "info", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.green,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          tag: "home", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.amber,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Account"),
            icon: Icon(Icons.account_circle),
          ),
          tag: "account", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.blueAccent,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Help"),
            icon: Icon(Icons.help),
          ),
          tag: "help", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.purple,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(Icons.settings),
          ),
          tag: "settings", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.yellow,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Theme"),
            icon: Icon(Icons.palette),
          ),
          tag: "theme", // Must Be Unique
        ),
      ],
    );
  }
}

```