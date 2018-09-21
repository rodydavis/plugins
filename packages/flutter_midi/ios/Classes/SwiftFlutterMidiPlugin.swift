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
    switch call.method {
      case "prepare_midi":
        #if targetEnvironment(simulator)
          let message = "Could Not Load Midi on this Device. (Cannot run on simulator), have you included the sound font?"
        result(message)
        #else
          au = AudioUnitMIDISynth()
          let message = "Prepared Sound Font"
          result(message)
        #endif
      case "play_midi_note":
         _arguments = call.arguments as! [String : Any];
        #if targetEnvironment(simulator)
          result(FlutterError(code: "play_midi_note_error", message: "Cannot play midi on this device!", details: "Cannot play midi on a Simulator. Test on a real device."))
        #else
          let midi = _arguments["note"] as? Int
          au.playPatch2On(midi: midi ?? 60)
          let message = "Playing: \(String(describing: midi))"
          result(message)
        #endif
      default:
          result(FlutterMethodNotImplemented)
        break
    }
  }
}
