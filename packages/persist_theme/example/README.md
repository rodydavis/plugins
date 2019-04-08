# persist_theme_example

``` dart
import 'package:flutter/material.dart';

import 'package:persist_theme/persist_theme.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

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


```