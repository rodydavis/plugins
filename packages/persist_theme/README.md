[![Buy Me A Coffee](https://img.shields.io/badge/Donate-Buy%20Me%20A%20Coffee-yellow.svg)](https://www.buymeacoffee.com/rodydavis)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=WSH3GVC49GNNJ)

# persist_theme

A Flutter plugin for persiting and dynamicly changing the theme.

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
