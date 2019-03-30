import 'package:flutter/material.dart';
import 'package:jaguar/jaguar.dart';

import 'package:sheet_music/sheet_music.dart';
import 'package:jaguar_flutter_asset/jaguar_flutter_asset.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SheetMusic(
        scale: "C Major",
        pitch: "C4",
        trebleClef: true,
      ),
    );
  }
}
