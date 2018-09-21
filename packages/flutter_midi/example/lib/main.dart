import 'package:flutter/material.dart';

import 'package:flutter_midi/flutter_midi.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// When [true] the note will be played for as long as the button is pressed
  /// The sound starts the second the button is touched.
  ///
  /// When [false] the sound will be play when the button is pressed.
  /// If the user cancels the touch on drag the sound will not be played.
  /// In this mode the sound will play for a default time.

  bool _toggle = true;

  @override
  void initState() {
    _initPlatformState();
    super.initState();
  }

  void _initPlatformState() async {
    /// Needed so that the sound font is loaded
    /// On iOS make sure to include the sound_font.SF2 in the Runner folder.
    /// This does not work in the simulator.
    final String _message = await FlutterMidi.prepare();
    print(_message);
  }

  void _playMidi(int midi) {
    FlutterMidi.playMidiNote(midi: midi)
        .then((dynamic message) => print(message))
        .catchError((dynamic e) => print(e));
  }

  void _stopMidi() {
    FlutterMidi.stopMidiNote()
        .then((dynamic message) => print(message))
        .catchError((dynamic e) => print(e));
  }

  Widget _playButton({int midi, String name}) {
    return Container(
      color: Colors.blue,
      child: Listener(
        onPointerDown: (dynamic e) => _toggle ? _playMidi(midi) : null,
        onPointerUp: (dynamic e) => _toggle ? _stopMidi() : null,
        child: InkWell(
          onTap: _toggle ? null : () => _playMidi(midi),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Play Midi Note'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(children: <Widget>[
            ListTile(
              title: const Text('Toggle Mode'),
              trailing: Switch(
                value: _toggle,
                onChanged: (bool value) => setState(() => _toggle = value),
              ),
            ),
            ButtonBar(mainAxisSize: MainAxisSize.min, children: <Widget>[
              _playButton(midi: 60, name: "C"),
              _playButton(midi: 64, name: "E"),
              _playButton(midi: 67, name: "G"),
            ]),
          ])),
        ),
      ),
    );
  }
}
