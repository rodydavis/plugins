import Flutter
import UIKit
import AVFoundation
    
public class SwiftFlutterMidiPlugin: NSObject, FlutterPlugin {
  var message = "Please Send Message"
  var _arguments = [String: Any]()
  var au: AudioUnitMIDISynth!

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_midi", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterMidiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    #if targetEnvironment(simulator)
      let message = "Could Not Load Midi on this Device. (Cannot run on simulator), have you included the sound font?"
      result(message)
    #else
    switch call.method {
      case "prepare_midi":
        au = AudioUnitMIDISynth()
        let message = "Prepared Sound Font"
        result(message)
      case "play_midi_note":
        _arguments = call.arguments as! [String : Any];
        let midi = _arguments["note"] as? Int
        au.playPatch2On(midi: midi ?? 60)
        let message = "Playing: \(String(describing: midi))"
        result(message)
      case "stop_midi_note":
        au.playPatch2Off()
        let message = "Stopped Playing"
        result(message)
      default:
        result(FlutterMethodNotImplemented)
        break
    }
    #endif
  }
}
