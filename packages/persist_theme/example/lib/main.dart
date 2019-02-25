import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
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
      _model.loadFromDisk();
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persist Theme'),
      ),
      body: ListView(
        children: <Widget>[],
      ),
    );
  }
}
