import UIKit
import Flutter
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
     GeneratedPluginRegistrant.register(with: self)
       if #available(iOS 10.0, *) {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
       }
    GMSServices.provideAPIKey("AIzaSyAp4W3h50iESesQXflHU1dfVbDAG0QrD2Y")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
