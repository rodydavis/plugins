[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# dynamic_tabs

A Flutter plugin for letting the user edit the bottom tabs like the Curpertino iTunes App.

## Getting Started

* Set `persistIndex` to `true` for saving the index of the current tab to disk, everytime the app launches it will open the last tab opened
* Tags must be set for each item and must be unique
* There are 2 Modes `DynamicTabScaffold.adaptive` and `DynamicTabScaffold`. The latter just show material
* When using `adaptive` mode the iOS Platform will be wrapped in a CupertinoTabBar and CurpertinoTabView, this means that the navigation can be perserved per tab and that the nav bar will be shown still on push. On Android it will push the whole screen
* This widget allows you to use a stateless widget for navigation
* This supports Dark Mode
* If there are more than 5 Tabs there will be a 5th Tab Created Call "More" and it will show a list of the remaining tabs
* On the edit screen the user can reorder that tabs to the nav bar as they wish, this will also be saved to disk
* If Using `.adaptive` Cupertino Widgets are Required and YOu will have to provide the routes for the Navigator.
* You can set the max number of tabs

## Screenshots

![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/1.PNG)
![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/2.PNG)
![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/3.PNG)
![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/4.PNG)
![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/5.PNG)
![](https://github.com/AppleEducate/plugins/blob/master/packages/dynamic_tabs/screenshots/6.PNG)

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