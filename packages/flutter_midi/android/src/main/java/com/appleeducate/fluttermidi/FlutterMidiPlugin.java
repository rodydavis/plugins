package com.appleeducate.fluttermidi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import org.billthefarmer.mididriver.MidiDriver;
import android.util.Log;

/** FlutterMidiPlugin */
public class FlutterMidiPlugin implements MethodCallHandler, MidiDriver.OnMidiStartListener {
  private MidiDriver midiDriver;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_midi");
    channel.setMethodCallHandler(new FlutterMidiPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("prepare_midi")) {
      // Instantiate the driver.
      midiDriver = new MidiDriver();
      // Set the listener.
      midiDriver.setOnMidiStartListener(this);
      midiDriver.start();
    } else if (call.method.equals("play_midi_note")) {
       String _note = call.argument("note");
       byte[] event = new byte[3];
       event[0] = (byte) (0x90 | 0x00);  // 0x90 = note On, 0x00 = channel 1
       event[1] = (byte) Byte.valueOf(_note);  // 0x3C = middle C
       event[2] = (byte) 0x7F;  // 0x7F = the maximum velocity (127)

      // Internally this just calls write() and can be considered obsoleted:
      //midiDriver.queueEvent(event);

      // Send the MIDI event to the synthesizer.
      midiDriver.write(event);

    } else if (call.method.equals("stop_midi_note")) {
      String _note = call.argument("note");
      byte[] event = new byte[3];
      // Construct a note OFF message for the middle C at minimum velocity on channel 1:
      event[0] = (byte) (0x80 | 0x00);  // 0x80 = note Off, 0x00 = channel 1
      event[1] = (byte) 0x3C;  // 0x3C = middle C
      event[2] = (byte) 0x00;  // 0x00 = the minimum velocity (0)

      // Send the MIDI event to the synthesizer.
      midiDriver.write(event);

    } else {
//      result.notImplemented();
    }
  }

  @Override
  public void onMidiStart() {
    Log.d(this.getClass().getName(), "onMidiStart()");
  }
}
