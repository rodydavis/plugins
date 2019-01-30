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
    load(_value);
    super.initState();
  }

  void load(String asset) async {
    print("Loading File...");
    FlutterMidi.unmute();
    ByteData _byte = await rootBundle.load(asset);
    //assets/sf2/SmallTimGM6mb.sf2
    //assets/sf2/Piano.SF2
    FlutterMidi.prepare(sf2: _byte, name: _value.replaceAll("assets/sf2/", ""));
  }

  String _value = "assets/sf2/SmallTimGM6mb.sf2";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("Soft Piano"),
                  value: "assets/sf2/SmallTimGM6mb.sf2",
                ),
                DropdownMenuItem(
                  child: Text("Loud Piano"),
                  value: "assets/sf2/Piano.SF2",
                ),
              ],
              onChanged: (String value) {
                setState(() {
                  _value = value;
                });
                load(_value);
              },
            ),
            RaisedButton(
              child: Text("Play C"),
              onPressed: () {
                FlutterMidi.playMidiNote(midi: 60);
              },
            ),
          ],
        )),
      ),
    );
  }
}
