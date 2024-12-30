import FlutterMacOS

public class SwiftLibresampleFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "libresample_flutter", binaryMessenger: registrar.messenger)
    let instance = SwiftLibresampleFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("macOS <todo version>")
  }
}
