import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math' as math;
import 'screens/page_1.dart';
import 'screens/page_2.dart';
import 'screens/page_3.dart';
import 'screens/page_4.dart';
import 'screens/page_5.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
        Locale('he', 'IL'),
      ],
      home: NativeAppLook(),
    );
  }
}

class NativeAppLook extends StatefulWidget {
  @override
  NativeAppLookState createState() {
    return new NativeAppLookState();
  }
}

class NativeAppLookState extends State<NativeAppLook> {
  int _currentIndex = 0;

  final _pages = <Widget>[
    Page1(),
    Page2(),
    Page3(),
    CupertinoPickerDemo(),
    Page5(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: NativeScaffold(
          body: _pages[_currentIndex],
          bottomBar: NativeBottomTabBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                title: Text("Info"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                title: Text("Settings"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.security),
                title: Text("Demo"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                title: Text("List"),
              ),
            ],
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }
}
