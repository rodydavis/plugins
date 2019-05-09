# mobile_sidebar_example

Demonstrates how to use the mobile_sidebar plugin.

## Screenshots



## Example

``` dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:mobile_sidebar/mobile_sidebar.dart';

void main() {
  _setTargetPlatformForDesktop();
  runApp(MyApp());
}

/// If the current platform is desktop, override the default platform to
/// a supported platform (iOS for macOS, Android for Linux and Windows).
/// Otherwise, do nothing.
void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showList = false;
  final _breakpoint = 800.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Side Menu Example'),
        actions: <Widget>[
          if (MediaQuery.of(context).size.width < _breakpoint) ...[
            IconButton(
              icon: Icon(_showList ? Icons.grid_on : Icons.grid_off),
              onPressed: () {
                if (mounted)
                  setState(() {
                    _showList = !_showList;
                  });
              },
            )
          ]
        ],
      ),
      body: MobileSidebar(
        items: <MenuItem>[
          MenuItem(
            icon: Icons.edit,
            color: Colors.black,
            title: 'Manage',
            subtitle: 'Edit, Share, Delete',
            child: Container(color: Colors.blueAccent),
          ),
          MenuItem(
            icon: Icons.event,
            color: Colors.blueAccent,
            title: 'Tasks',
            subtitle: 'Personal Tasks',
            child: Container(color: Colors.purpleAccent),
          ),
          MenuItem(
            icon: Icons.timer,
            color: Colors.blueGrey,
            title: 'Log',
            subtitle: 'History of Results',
            child: Container(color: Colors.black),
          ),
          MenuItem(
            icon: Icons.star,
            color: Colors.amber,
            title: 'Favorites',
            subtitle: 'Custom List',
            child: Container(color: Colors.yellowAccent),
          ),
        ],
        showList: _showList,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          heroTag: 'create-contact',
          label: Text('Add new item'),
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
```