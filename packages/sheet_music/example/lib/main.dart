import 'package:flutter/material.dart';

import 'package:sheet_music/sheet_music.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sheet Music Example'),
        ),
        body: Center(
          child: SheetMusic(
            scale: "C Major",
            pitch: "C4",
            trebleClef: true,
          ),
        ),
      ),
    );
  }
}
