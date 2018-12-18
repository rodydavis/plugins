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

class NativeAppLook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print(MaterialLocalizations.of(context));
    final bool showMaterial = false;

    return NativeScaffold(
      hideAppBar: true,
      androidTopNavigation: false,
      showMaterial: showMaterial,
      title: Text("Native Appbar"),
      body: Container(),
      tabs: [
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          title: Text("Info"),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          title: Text("About"),
        ),
      ],
      pages: <Widget>[
        Page1(),
        Container(
          child: Center(child: Icon(Icons.settings)),
        ),
      ],
      leading: Icon(Icons.menu),
      actions: <Widget>[
        Icon(Icons.share),
      ],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.info),
        onPressed: () =>
            showAlertPopup(context, "Native Dialog", "Button Submitted!"),
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

class Page1 extends StatefulWidget {
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  bool _active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NativeAppBar(
        title: Text("Home"),
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
              padding: const EdgeInsets.all(20.0),
              color: Colors.blue,
              onPressed: () =>
                  showAlertPopup(context, "Native Dialog", "Button Submitted!"),
            ),
          ],
        ),
      ),
    );
  }
}
