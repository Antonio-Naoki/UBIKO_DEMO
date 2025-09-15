import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Read the API key from environment variables set by the .xcconfig file.
    let apiKey = ProcessInfo.processInfo.environment["GOOGLE_MAPS_API_KEY"] ?? ""
    GMSServices.provideAPIKey(apiKey)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
