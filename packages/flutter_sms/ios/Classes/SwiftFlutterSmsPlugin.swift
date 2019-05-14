import Flutter
import UIKit
import MessageUI

public class SwiftFlutterSmsPlugin: NSObject, FlutterPlugin, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    var result: FlutterResult?
    var _arguments = [String: Any]()

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_sms", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterSmsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    _arguments = call.arguments as! [String : Any];
    switch call.method {
    case "sendSMS":
      #if targetEnvironment(simulator)
        result(FlutterError(
            code: "message_not_sent",
            message: "Cannot send message on this device!",
            details: "Cannot send SMS and MMS on a Simulator. Test on a real device."
          )
        )
      #else
        if (MFMessageComposeViewController.canSendText()) {
          self.result = result
          let controller = MFMessageComposeViewController()
          controller.body = _arguments["message"] as? String
          controller.recipients = _arguments["recipients"] as? [String]
          controller.messageComposeDelegate = self
          UIApplication.shared.keyWindow?.rootViewController?.present(controller, animated: true, completion: nil)
        } else {
          result(FlutterError(
              code: "device_not_capable",
              message: "The current device is not capable of sending text messages.",
              details: "A device may be unable to send messages if it does not support messaging or if it is not currently configured to send messages. This only applies to the ability to send text messages via iMessage, SMS, and MMS."
            )
          )
        }
      #endif

    case "canSendSMS":
      #if targetEnvironment(simulator)
        result(false)
      #else
        if (MFMessageComposeViewController.canSendText()) {
          result(true)
        } else {
          result(false)
        }
      #endif

    default:
        result(FlutterMethodNotImplemented)
      break
    }
  }

  public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
    let map: [MessageComposeResult: String] = [
        MessageComposeResult.sent: "sent",
        MessageComposeResult.cancelled: "cancelled",
        MessageComposeResult.failed: "failed",
    ]
    if let callback = self.result {
        callback(map[result])
    }
    UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
  }
}
