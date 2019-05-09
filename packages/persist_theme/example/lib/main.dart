import 'package:flutter/material.dart';

import 'package:persist_theme/persist_theme.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

// The existing imports
// !! Keep your existing impots here !!

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModel _model = ThemeModel();

  @override
  void initState() {
    try {
      _model.init();
    } catch (e) {
      print("Error Loading Theme: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
      model: _model,
      child: new ScopedModelDescendant<ThemeModel>(
        builder: (context, child, model) => MaterialApp(
              theme: model.theme,
              darkTheme: model.darkTheme,
              home: HomeScreen(),
            ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ScopedModel.of<ThemeModel>(context, rebuildOnChange: true);
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
                    Flexible(child: PrimaryColorPicker(type: PickerType.block)),
                    Flexible(child: AccentColorPicker(type: PickerType.block)),
                  ],
                ),
                DarkAccentColorPicker(type: PickerType.block),
              ]
            : <Widget>[
                DarkModeSwitch(),
                TrueBlackSwitch(),
                CustomThemeSwitch(),
                PrimaryColorPicker(type: PickerType.block),
                AccentColorPicker(type: PickerType.block),
                DarkAccentColorPicker(type: PickerType.block),
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
