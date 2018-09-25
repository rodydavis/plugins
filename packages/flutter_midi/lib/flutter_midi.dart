import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

class FlutterMidi {
  static const MethodChannel _channel = MethodChannel('flutter_midi');

  /// Needed so that the sound font is loaded
  /// On iOS make sure to include the sound_font.SF2 in the Runner folder.
  /// This does not work in the simulator.
  static Future<String> prepare() async {
    final String result = await _channel.invokeMethod('prepare_midi');
    return result;
  }

  /// Unmute the device temporarly even if the mute switch is on or toggled in settings.
  static Future<String> unmute() async {
    final String result = await _channel.invokeMethod('unmute');
    return result;
  }

  /// Use this when stopping the sound onTouchUp or to cancel a long file.
  /// Not needed if playing midi onTap.
  static Future<String> stopMidiNote() async {
    final String result = await _channel.invokeMethod('stop_midi_note');
    return result;
  }

  /// Play a midi note from the sound_font.SF2 library bundled with the application.
  /// Play a midi note in the range between 0-256
  /// Multiple notes can be played at once as seperate calls.
  static Future<String> playMidiNote({
    @required int midi,

    /// Force play the sound even if the mute switch is on or toggled on in the settings.
    /// This will not always work on every device, but is required this way by Apple.
    bool unmute,
  }) async {
    final Map<dynamic, dynamic> mapData = <dynamic, dynamic>{};
    print("Pressed: $midi");
    mapData["note"] = midi;
    if (unmute != null && unmute) {
      return await _channel.invokeMethod('play_midi_note_unmute', mapData);
    }
    return await _channel.invokeMethod('play_midi_note', mapData);
  }
}
