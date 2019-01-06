import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:native_widgets/native_widgets.dart';

import 'screens/page_1.dart';
import 'screens/page_2.dart';
import 'screens/page_3.dart';
import 'screens/page_5.dart';
import 'utils/cupertino_navigation_demo.dart';
//import 'screens/page_4.dart';

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

class NativeAppLook extends StatelessWidget {
//  @override
//  NativeAppLookState createState() {
//    return new NativeAppLookState();
//  }
//}
//
//class NativeAppLookState extends State<NativeAppLook> {
//  int _currentIndex = 0;
//
//  final _pages = <Widget>[
//    Page1(),
//    Page2(),
//    Page3(),
////    CupertinoPickerDemo(),
//    CupertinoNavigationDemo(),
//    Page5(),
//  ];

  @override
  Widget build(BuildContext context) {
//    return DefaultTabController(
//        length: 3,
//        child: NativeScaffold(
//          body: _pages[_currentIndex],
//          bottomBar: NativeBottomTabBar(
//            activeColor: Colors.blue,
//            items: [
//              BottomNavigationBarItem(
//                icon: Icon(Icons.info),
//                title: Text("Info"),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.search),
//                title: Text("Search"),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.list),
//                title: Text("Table"),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.select_all),
//                title: Text("Selection"),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.star),
//                title: Text("Master Detail"),
//              ),
//            ],
//            onTap: (int index) {
//              setState(() {
//                _currentIndex = index;
//              });
//            },
//          ),
//        ));
    return NativeTabScaffold(
      tabs: [
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text("Info"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text("Table"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.select_all),
          title: Text("Selection"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: Text("Master Detail"),
        ),
      ],
      pages: <Widget>[
        Page1(),
        NativeTabView(
          title: "Nav Demo",
          child: Page2(),
        ),
        Page3(),
//    CupertinoPickerDemo(),
        CupertinoNavigationDemo(),
        Page5(),
      ],
    );
  }
}
