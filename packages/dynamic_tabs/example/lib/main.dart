import 'package:flutter/material.dart';

import 'package:dynamic_tabs/dynamic_tabs.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicTabScaffold.adaptive(
        tabs: <DynamicTab>[
          DynamicTab(
            child: Container(
              color: Colors.redAccent,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Info"),
              icon: Icon(Icons.info),
            ),
            tag: "info",
          ),
          DynamicTab(
            child: Container(
              color: Colors.green,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            tag: "home",
          ),
          DynamicTab(
            child: Container(
              color: Colors.amber,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Account"),
              icon: Icon(Icons.account_circle),
            ),
            tag: "account",
          ),
          DynamicTab(
            child: Container(
              color: Colors.blueAccent,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Help"),
              icon: Icon(Icons.help),
            ),
            tag: "help",
          ),
          DynamicTab(
            child: Container(
              color: Colors.purple,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Settings"),
              icon: Icon(Icons.settings),
            ),
            tag: "settings",
          ),
          DynamicTab(
            child: Container(
              color: Colors.yellow,
            ),
            tab: BottomNavigationBarItem(
              title: Text("Theme"),
              icon: Icon(Icons.palette),
            ),
            tag: "theme",
          ),
        ],
      ),
    );
  }
}
