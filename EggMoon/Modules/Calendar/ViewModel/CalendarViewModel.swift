import Foundation
import Combine

final class CalendarViewModel: ObservableObject {
    
    private let moonPhaseCalculator = MoonPhaseCalculator()
    
    @Published var selectedDate = Date()
    @Published private(set) var todayMoonPhase: MoonPhase?
    
    private var anyCanceller: AnyCancellable?
    
    init() {
        observeSelectedDate()
    }
    
    private func observeSelectedDate() {
        anyCanceller = $selectedDate
            .sink { [weak self] date in
                guard let self else { return }
                self.todayMoonPhase = self.moonPhaseCalculator.phase(for: date)
            }
    }
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

struct TrackingURLBuilder {
    static func buildTrackingURL(from response: MetricsResponse, idfa: String?, bundleID: String) -> URL? {
        let onesignalId = OneSignal.User.onesignalId
        
        if response.isOrganic {
            guard var components = URLComponents(string: response.url) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = components.queryItems ?? []
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
            } else {
                print("OneSignal ID not available for organic URL")
            }
            
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let url = components.url else {
                return nil
            }
            print(url)
            return url
        } else {
            let subId2 = response.parameters["sub_id_2"]
            let baseURLString = subId2 != nil ? "\(response.url)/\(subId2!)" : response.url
            
            guard var newComponents = URLComponents(string: baseURLString) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = []
            queryItems = response.parameters
                .filter { $0.key != "sub_id_2" }
                .map { URLQueryItem(name: $0.key, value: $0.value) }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            
            // Add OneSignal ID
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
                print("🔗 Added OneSignal ID to non-organic URL: \(onesignalId)")
            } else {
                print("⚠️ OneSignal ID not available for non-organic URL")
            }
            
            newComponents.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let finalURL = newComponents.url else {
                return nil
            }
            print(finalURL)
            return finalURL
        }
    }
}
