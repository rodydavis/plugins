import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    load('assets/sf2/SmallTimGM6mb.sf2');
    super.initState();
  }

  void load(String asset) async {
    print("Loading File...");
    FlutterMidi.unmute();
    ByteData _byte = await rootBundle.load(asset);
    //assets/sf2/SmallTimGM6mb.sf2
    //assets/sf2/Piano.SF2
    FlutterMidi.prepare(sf2: _byte);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Play C"),
            onPressed: () {
              FlutterMidi.playMidiNote(midi: 60);
            },
          ),
        ),
      ),
    );
  }
}
