import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
  _NativeAppLookState createState() => _NativeAppLookState();
}

class _NativeAppLookState extends State<NativeAppLook> {
  int _currentIndex = 0;
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    print(MaterialLocalizations.of(context));
    return Scaffold(
      appBar: NativeAppBar(
        tabs: <Widget>[],
      
        title: const Text('Native Widgets'),
        leading: const IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => showAboutDialog(
                  context: context,
                  applicationName: 'Native Widgets',
                  applicationIcon: const Icon(Icons.star),
                ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text("Loading Indicator..."),
              trailing: NativeLoadingIndicator(),
            ),
            ListTile(
              title: const Text("Switch"),
              trailing: NativeSwitch(
                value: _active,
                onChanged: (bool value) => setState(() => _active = value),
              ),
            ),
            NativeButton(
              child: const Text("Submit"),
              paddingExternal: const EdgeInsets.all(20.0),
              buttonColor: Colors.blue,
              onPressed: () =>
                  showAlertPopup(context, "Native Dialog", "Button Submitted!"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NativeBottomTabBar(
        currentIndex: _currentIndex,
        onTap: (int value) => setState(() => _currentIndex = value),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            title: Text("Home"),
            icon: Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
            title: Text("Settings"),
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showSimpleDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showSimpleDialog<void>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'Delete',
              isDestructive: true,
              onPressed: () {
                Navigator.pop(context);
              }),
          NativeDialogAction(
              text: 'Ok',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
