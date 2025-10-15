import SwiftUI

struct HistoryView: View {
    
    @StateObject private var viewModel = HistoryViewModel()
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image(.Images.BG)
                    .resize()
                
                VStack {
                    navigation
                    
                    if viewModel.observations.isEmpty {
                        stumb
                    } else {
                        observations
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .onAppear {
                viewModel.loadObservations()
                isShowTabBar = true
            }
            .navigationDestination(for: HistoryScreen.self) { screen in
                switch screen {
                    case .add(let observation):
                        AddObservationView(observation: observation) { newObservation in
                            viewModel.save(newObservation)
                        }
                    case .detail(let observation):
                        ObservationDetailView(observation: observation) { newObservation in
                            viewModel.save(newObservation)
                        } removeAction: { removedObservation in
                            viewModel.remove(removedObservation)
                        }
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        Text("History of observations")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .font(.system(size: 35, weight: .light))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    private var stumb: some View {
        VStack(spacing: 24) {
            Image(systemName: "multiply")
                .font(.system(size: 150, weight: .bold))
                .foregroundStyle(.white.opacity(0.5))
            
            VStack(spacing: 16) {
                Text("This will display your history of egg mass observations")
                    .font(.system(size: 25, weight: .light))
                    .foregroundStyle(.white)
                
                Text("You will be able to keep records on different days, track the number of eggs, compare the indicators with the phases of the moon and mark the success or failure of the withdrawal of chickens")
                    .font(.system(size: 11, weight: .light))
                    .foregroundStyle(.white.opacity(0.5))
            }
            .multilineTextAlignment(.center)
            
            addButton
        }
        .padding(.vertical, 30)
        .padding(.horizontal, 28)
        .background(.white.opacity(0.12))
        .cornerRadius(23)
        .overlay {
            RoundedRectangle(cornerRadius: 23)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.bottom, 100)
    }
    
    private var addButton: some View {
        Button {
            isShowTabBar = false
            viewModel.navigationPath.append(.add(Observation(isMock: false)))
        } label: {
            Text("Add observation")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(.emRed)
                .background(.emPink)
                .cornerRadius(20)
        }
    }
    
    private var observations: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.observations) { observation in
                    ObservationCellView(observation: observation) {
                        isShowTabBar = false
                        viewModel.navigationPath.append(.detail(observation))
                    }
                }
                
                addButton
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 100)
    }
}

#Preview {
    HistoryView(isShowTabBar: .constant(false))
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


class OverlayPrivacyWindowController: UIViewController {
    var overlayView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
