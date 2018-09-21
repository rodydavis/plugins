import 'package:flutter/material.dart';

import 'package:flutter_midi/flutter_midi.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    final String _message = await FlutterMidi.prepare();
    print(_message);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Play Midi Note'),
        ),
        body: new Center(
          child: RaisedButton(
            child: const Icon(Icons.play_arrow),
            onPressed: () => FlutterMidi.playMidiNote(midi: 60),
          ),
        ),
      ),
    );
  }
}
