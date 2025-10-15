import SwiftUI

struct CalendarView: View {
    
    @StateObject private var viewModel = CalendarViewModel()
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 24) {
                        moonMessage
                        todayMoon
                        datePicker
                    }
                    .padding(.top, 2)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 90)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.smooth, value: viewModel.selectedDate)
        }
    }
    
    private var navigation: some View {
        Text("Lunar calendar")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .font(.system(size: 35, weight: .light))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    private var moonMessage: some View {
        VStack(spacing: 3) {
            Image(systemName: "bell.fill")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.emPink)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(viewModel.todayMoonPhase?.recommendation ?? "N/A")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15, weight: .light))
                .foregroundStyle(.white.opacity(0.5))
                .multilineTextAlignment(.leading)
        }
        .padding(16)
        .background(.white.opacity(0.12))
        .cornerRadius(30)
        .overlay {
            RoundedRectangle(cornerRadius: 30)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
    }
    
    private var todayMoon: some View {
        VStack(spacing: 20) {
            VStack(spacing: 10) {
                Text(viewModel.selectedDate.formatted(.dateTime.weekday(.wide)))
                    .font(.system(size: 24, weight: .light))
                    .foregroundStyle(.white)
                
                Text(viewModel.selectedDate.formatted(.dateTime.year().month(.twoDigits).day()))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(.white.opacity(0.5))
            }
            
            if let moonPhase = viewModel.todayMoonPhase {
                Image(moonPhase.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 205)
                    .clipped()
                    .shadow(color: .white.opacity(0.5), radius: 20)
                    .overlay {
                        Text(moonPhase.phase)
                            .font(.system(size: 22, weight: .regular))
                            .foregroundStyle(.white.opacity(0.45))
                    }
            }
        }
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $viewModel.selectedDate, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.graphical)
            .tint(.emPink)
            .colorScheme(.dark)
            .padding()
            .background(.white.opacity(0.12))
            .cornerRadius(40)
    }
}

#Preview {
    CalendarView(isShowTabBar: .constant(false))
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

class PermissionManager {
    static let shared = PermissionManager()
    
    private var hasRequestedTracking = false
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        OneSignal.Notifications.requestPermission({ accepted in
            DispatchQueue.main.async {
                completion(accepted)
            }
        }, fallbackToSettings: false)
    }
    
    func requestTrackingAuthorization(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            func checkAndRequest() {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .notDetermined {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    checkAndRequest()
                                }
                            } else {
                                self.hasRequestedTracking = true
                                let idfa = newStatus == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                                completion(idfa)
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        self.hasRequestedTracking = true
                        let idfa = status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                        completion(idfa)
                    }
                }
            }
            
            DispatchQueue.main.async {
                checkAndRequest()
            }
        } else {
            DispatchQueue.main.async {
                self.hasRequestedTracking = true
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            }
        }
    }
}
