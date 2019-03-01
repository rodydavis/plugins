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
    return DynamicTabScaffold(
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
        DynamicTab(
          child: Container(
            color: Colors.purple,
          ),
          tab: BottomNavigationBarItem(
            title: Text("FAQ"),
            icon: Icon(Icons.perm_contact_calendar),
          ),
          tag: "faq", // Must Be Unique
        ),
        DynamicTab(
          child: Container(
            color: Colors.yellow,
          ),
          tab: BottomNavigationBarItem(
            title: Text("Contacts"),
            icon: Icon(Icons.people),
          ),
          tag: "contacts", // Must Be Unique
          trailingAction: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
