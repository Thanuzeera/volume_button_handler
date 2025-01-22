// import Flutter
// import UIKit

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import AVFoundation
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  var channel: FlutterMethodChannel?
  var lastVolume: Float = 0.5
  var volumeObservation: NSKeyValueObservation?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    channel = FlutterMethodChannel(name: "com.example.volume_button_handler",
                                   binaryMessenger: controller.binaryMessenger)

    // Set up volume observation
    setupVolumeObservation()

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func setupVolumeObservation() {
    do {
      let audioSession = AVAudioSession.sharedInstance()
      try audioSession.setActive(true)
      lastVolume = audioSession.outputVolume

      volumeObservation = audioSession.observe(\.outputVolume, options: [.new]) { [weak self] (session, change) in
        guard let self = self, let newVolume = change.newValue else { return }
        if newVolume > self.lastVolume {
          // "Volume up" inferred
          self.channel?.invokeMethod("volumeUpPressed", nil)
        } else if newVolume < self.lastVolume {
          // "Volume down" inferred
          self.channel?.invokeMethod("volumeDownPressed", nil)
        }
        self.lastVolume = newVolume
      }
    } catch {
      print("Error setting up audio session: \(error)")
    }
  }
}
