import UIKit

enum MoonPhase: Codable {
    case newMoon
    case waxingCrescent
    case firstQuarter
    case waxingGibbous
    case fullMoon
    case waningGibbous
    case lastQuarter
    case waningCrescent
    
    var image: ImageResource {
        switch self {
            case .newMoon: return .Images.Calendar.img1
            case .waxingCrescent: return .Images.Calendar.img2
            case .firstQuarter: return .Images.Calendar.img3
            case .waxingGibbous: return .Images.Calendar.img4
            case .fullMoon: return .Images.Calendar.img5
            case .waningGibbous: return .Images.Calendar.img6
            case .lastQuarter: return .Images.Calendar.img7
            case .waningCrescent: return .Images.Calendar.img8
        }
    }
    
    var phase: String {
        switch self {
            case .newMoon: return "New Moon"
            case .waxingCrescent: return "Waxing Crescent"
            case .firstQuarter: return "First Quarter"
            case .waxingGibbous: return "Waxing Gibbous"
            case .fullMoon: return "Full Moon"
            case .waningGibbous: return "Waning Gibbous"
            case .lastQuarter: return "Last Quarter"
            case .waningCrescent: return "Waning Crescent"
        }
    }
    
    var recommendation: String {
        switch self {
            case .newMoon:
                return "Best time to set eggs in the incubator — high chick survival rate."
            case .waxingCrescent:
                return "Good period to start new processes on the farm. Keep the feeding balanced."
            case .firstQuarter:
                return "Egg production increases. Add more protein and calcium to the diet."
            case .waxingGibbous:
                return "Peak activity of the flock. Provide fresh water and keep bedding clean."
            case .fullMoon:
                return "Egg production may drop. Supplement with vitamins to support immunity."
            case .waningGibbous:
                return "Birds may become restless. Ensure calm and stable housing conditions."
            case .lastQuarter:
                return "Good time for cleaning, disinfection, and disease prevention measures."
            case .waningCrescent:
                return "Energy levels decrease. Reduce stress, provide rest and comfort."
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case invalidResponse
}

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


class ConfigManager {
    static let shared = ConfigManager()
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    private let defaults: [String: NSObject] = [AppConstants.remoteConfigKey: true as NSNumber]
    
    private init() {
        remoteConfig.setDefaults(defaults)
    }
    
    func fetchConfig(completion: @escaping (Bool) -> Void) {
        if let savedState = UserDefaults.standard.object(forKey: AppConstants.remoteConfigStateKey) as? Bool {
            completion(savedState)
            return
        }
        
        remoteConfig.fetch(withExpirationDuration: 0) { status, error in
            if status == .success {
                self.remoteConfig.activate { _, _ in
                    let isEnabled = self.remoteConfig.configValue(forKey: AppConstants.remoteConfigKey).boolValue
                    UserDefaults.standard.set(isEnabled, forKey: AppConstants.remoteConfigStateKey)
                    completion(isEnabled)
                }
            } else {
                UserDefaults.standard.set(true, forKey: AppConstants.remoteConfigStateKey)
                completion(true)
            }
        }
    }
    
    func getSavedURL() -> URL? {
        guard let urlString = UserDefaults.standard.string(forKey: AppConstants.userDefaultsKey),
              let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    func saveURL(_ url: URL) {
        UserDefaults.standard.set(url.absoluteString, forKey: AppConstants.userDefaultsKey)
    }
}
