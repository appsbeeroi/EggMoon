enum ChickOutput: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case successful
    case unsuccessful
    
    var title: String {
        switch self {
            case .successful:
                "Successful"
            case .unsuccessful:
                "Unsucessful"
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

struct BlackWindow<RootView: View>: View {
    @StateObject private var viewModel = BlackWindowViewModel()
    private let remoteConfigKey: String
    let rootView: RootView
    
    init(rootView: RootView, remoteConfigKey: String) {
        self.rootView = rootView
        self.remoteConfigKey = remoteConfigKey
    }
    
    var body: some View {
        Group {
            if viewModel.isRemoteConfigFetched && !viewModel.isEnabled && viewModel.isTrackingPermissionResolved && viewModel.isNotificationPermissionResolved {
                rootView
            } else if viewModel.isRemoteConfigFetched && viewModel.isEnabled && viewModel.trackingURL != nil && viewModel.shouldShowWebView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    PrivacyView(ref: viewModel.trackingURL!)
                }
            } else {
                ZStack {
                    rootView
                }
            }
        }
    }
}
