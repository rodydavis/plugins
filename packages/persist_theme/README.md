[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# persist_theme

A Flutter plugin for persiting and dynamicly changing the theme.

``` dart 
import 'package:flutter/material.dart';

import 'package:persist_theme/persist_theme.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

/// main is entry point of Flutter application
void main() {
  // Desktop platforms aren't a valid platform.
  _setTargetPlatformForDesktop();

  return runApp(MyApp());
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

final _model = ThemeModel();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableProvider<ThemeModel>(
      builder: (_) => _model..init(),
      child: Consumer<ThemeModel>(
        builder: (context, model, child) {
          return MaterialApp(
            theme: model.theme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = Provider.of<ThemeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persist Theme'),
      ),
      body: ListView(
        children: MediaQuery.of(context).size.width >= 480
            ? <Widget>[
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(child: DarkModeSwitch()),
                    Flexible(child: TrueBlackSwitch()),
                  ],
                ),
                CustomThemeSwitch(),
                Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Flexible(child: PrimaryColorPicker()),
                    Flexible(child: AccentColorPicker()),
                  ],
                ),
                DarkAccentColorPicker(),
              ]
            : <Widget>[
                DarkModeSwitch(),
                TrueBlackSwitch(),
                CustomThemeSwitch(),
                PrimaryColorPicker(),
                AccentColorPicker(),
                DarkAccentColorPicker(),
              ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _theme.accentColor,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}


```

## Customization

* There are widgets provided but can be fully customized.
* By default hide elements based on the theme.
* The only requirement is that the material app is wrapped in a scoped model like shown above.

## Screenshots

![](https://github.com/AppleEducate/plugins/blob/master/packages/persist_theme/screenshots/1.png)
![](https://github.com/AppleEducate/plugins/blob/master/packages/persist_theme/screenshots/2.png)
![](https://github.com/AppleEducate/plugins/blob/master/packages/persist_theme/screenshots/3.png)
![](https://github.com/AppleEducate/plugins/blob/master/packages/persist_theme/screenshots/4.png)
![](https://github.com/AppleEducate/plugins/blob/master/packages/persist_theme/screenshots/5.png)
