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
    _arguments = call.arguments as! [String : Any];
    switch call.method {
    case "play_midi_note":
      #if targetEnvironment(simulator)
      result(FlutterError(code: "play_midi_note_error", message: "Cannot play midi on this device!", details: "Cannot play midi on a Simulator. Test on a real device."))
      #else
      let midi = _arguments["note"] as? Int
      au = AudioUnitMIDISynth()
      au.playPatch2On(midi: midi ?? 60)
      let message = "Playing: \(String(describing: midi))"
      print(message)
      // let controller = MFMessageComposeViewController()
      // controller.body = _arguments["message"] as? String
      // controller.recipients = _arguments["recipients"] as? [String]
      // controller.messageComposeDelegate = self
      // UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
      result(message)
      #endif
    default:
        result(FlutterMethodNotImplemented)
      break
    }
  }

  // public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
  //   UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
  //     message = "Sent!"
  // }
}
