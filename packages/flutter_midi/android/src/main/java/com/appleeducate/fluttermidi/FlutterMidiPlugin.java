package com.appleeducate.fluttermidi;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import java.io.File;
import java.io.IOException;

import cn.sherlock.com.sun.media.sound.SF2Soundbank;
import cn.sherlock.com.sun.media.sound.SoftSynthesizer;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import jp.kshoji.javax.sound.midi.InvalidMidiDataException;
import jp.kshoji.javax.sound.midi.MidiUnavailableException;
import jp.kshoji.javax.sound.midi.Receiver;
import jp.kshoji.javax.sound.midi.ShortMessage;


/** FlutterMidiPlugin */
public class FlutterMidiPlugin implements MethodCallHandler {
    private SoftSynthesizer synth;
    private Receiver recv;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_midi");
    channel.setMethodCallHandler(new FlutterMidiPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
      if (call.method.equals("prepare_midi")) {
          try {
              String _path = call.argument("path");
              File _file = new File(_path);
              SF2Soundbank sf = new SF2Soundbank(_file);
              synth = new SoftSynthesizer();
              synth.open();
              synth.loadAllInstruments(sf);
              synth.getChannels()[0].programChange(0);
              synth.getChannels()[1].programChange(1);
              recv = synth.getReceiver();
          } catch (IOException e) {
              e.printStackTrace();
          } catch (MidiUnavailableException e) {
              e.printStackTrace();
          }
      } else  if (call.method.equals("change_sound")) {
          try {
              String _path = call.argument("path");
              File _file = new File(_path);
              SF2Soundbank sf = new SF2Soundbank(_file);
              synth = new SoftSynthesizer();
              synth.open();
              synth.loadAllInstruments(sf);
              synth.getChannels()[0].programChange(0);
              synth.getChannels()[1].programChange(1);
              recv = synth.getReceiver();
          } catch (IOException e) {
              e.printStackTrace();
          } catch (MidiUnavailableException e) {
              e.printStackTrace();
          }
      } else if (call.method.equals("play_midi_note")) {
          int _note = call.argument("note");
          try {
              ShortMessage msg = new ShortMessage();
              msg.setMessage(ShortMessage.NOTE_ON, 0, _note, 127);
              recv.send(msg, -1);
          } catch (InvalidMidiDataException e) {
              e.printStackTrace();
          }
      } else if (call.method.equals("stop_midi_note")) {
          int _note = call.argument("note");
          try {
              ShortMessage msg = new ShortMessage();
              msg.setMessage(ShortMessage.NOTE_OFF, 0, _note, 127);
              recv.send(msg, -1);
          } catch (InvalidMidiDataException e) {
              e.printStackTrace();
          }
      } else {
      }
  }
}
