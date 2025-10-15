import SwiftUI

import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private var lastPermissionCheck: Date?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize(AppConstants.oneSignalAppID, withLaunchOptions: launchOptions)
        
        UNUserNotificationCenter.current().delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTrackingAction),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        return true
    }
    
    @objc private func handleTrackingAction() {
        if UIApplication.shared.applicationState == .active {
            let now = Date()
            if let last = lastPermissionCheck, now.timeIntervalSince(last) < 2 {
                return
            }
            lastPermissionCheck = now
            NotificationCenter.default.post(name: .checkTrackingPermission, object: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

@main
struct EggMoonApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            BlackWindow(rootView: ContentView(), remoteConfigKey: AppConstants.remoteConfigKey)
        }
    }
}

struct AppConstants {
    static let metricsBaseURL = "https://noomsgge.com/app/metrics"
    static let salt = "ppWBV2tzr560kLp1CC4sVtkHFxljMofT"
    static let oneSignalAppID = "d19f06d5-f2a3-4852-9d8f-efff7bc351db"
    static let userDefaultsKey = "egg"
    static let remoteConfigStateKey = "eggMoon"
    static let remoteConfigKey = "isEggMoonEnable"
}

