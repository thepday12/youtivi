import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        GeneratedPluginRegistrant.register(with: self);
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController;
        let batteryChannel = FlutterMethodChannel.init(name: "youtivi/platform",
                                                       binaryMessenger: controller);
        batteryChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if ("getPlatformName" == call.method){
                self.getPlatformName(result:result)
            }
        });
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
    
    private func getPlatformName(result: FlutterResult) {
        result("IOS");
    }
}
