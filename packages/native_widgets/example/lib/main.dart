import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:native_widgets/native_widgets.dart';

import 'screens/page_1.dart';
import 'screens/page_2.dart';
import 'screens/page_3.dart';
import 'screens/page_4.dart';
import 'screens/page_5.dart';
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
  @override
  Widget build(BuildContext context) {
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
      pages: <NativeTabView>[
        NativeTabView(
          title: "Input Form",
          child: Page1(),
        ),
        NativeTabView(
          title: "Nav Demo",
          child: Page2(),
        ),
        NativeTabView(
          title: "Table View",
          child: Page3(),
        ),
        NativeTabView(
          title: "Selection Demo",
//          child: CupertinoNavigationDemo(),
          child: CupertinoPickerDemo(),
        ),
        NativeTabView(
          title: "Master Detail",
          child: Page5(),
        ),
      ],
    );
  }
}
