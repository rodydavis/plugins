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
      debugShowCheckedModeBanner: false,
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
  bool _bottomNav = false;
  final _breakpoint = 800.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_bottomNav
          ? AppBar(
              title: Text('Mobile Sidebar Example'),
            )
          : null,
      body: MobileSidebar(
        breakPoint: _breakpoint,
        persistIndex: true,
        mobileBottomNavigation: _bottomNav,
        nestedNavigation: true,
        items: <MenuItem>[
          MenuItem(
            icon: Icons.edit,
            color: Colors.black,
            title: 'Manage',
            subtitle: 'Edit, Share, Delete',
            child: NewScreen(
              color: Colors.blueAccent,
              name: 'Blue Screen',
            ),
          ),
          MenuItem(
            icon: Icons.event,
            color: Colors.blueAccent,
            title: 'Tasks',
            subtitle: 'Personal Tasks',
            child: NewScreen(
              color: Colors.purpleAccent,
              name: 'Purple Screen',
            ),
          ),
          MenuItem(
            icon: Icons.timer,
            color: Colors.blueGrey,
            title: 'Log',
            subtitle: 'History of Results',
            child: NewScreen(
              color: Colors.black,
              name: 'Black Screen',
            ),
          ),
          MenuItem(
            icon: Icons.star,
            color: Colors.amber,
            title: 'Favorites',
            subtitle: 'Custom List',
            child: NewScreen(
              color: Colors.yellow,
              name: 'Yellow Screen',
            ),
          ),
        ],
        showList: _showList,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.redAccent,
          heroTag: 'toggle_grid',
          label: Text('${_bottomNav ? 'Hide' : 'Show'} Bottom Bar'),
          icon: Icon(Icons.border_bottom),
          onPressed: () {
            if (mounted)
              setState(() {
                _bottomNav = !_bottomNav;
              });
          },
        ),
      ),
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({
    Key key,
    @required this.color,
    @required this.name,
  }) : super(key: key);

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
      ),
      body: Container(
        color: color,
        child: Center(
          child: RaisedButton.icon(
            icon: Icon(Icons.arrow_right),
            label: Text("Push to Screen"),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => NewScreen(color: color, name: name),
              ));
            },
          ),
        ),
      ),
    );
  }
}
