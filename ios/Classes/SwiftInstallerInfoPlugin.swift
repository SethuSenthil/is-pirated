import Flutter
import UIKit

public class SwiftIsPiratedPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.sethusenthil.is_pirated", binaryMessenger: registrar.messenger())
        let instance = SwiftIsPiratedPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getIsPirated" {
            if let path = Bundle.main.appStoreReceiptURL?.path {
                if path.contains("CoreSimulator") {
                    result("com.apple.CoreSimulator")
                } else if path.contains("sandboxReceipt") {
                    result("com.apple.TestFlight")
                } else {
                    result("com.apple.AppStore")
                }
            } else {
                result(nil)
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
