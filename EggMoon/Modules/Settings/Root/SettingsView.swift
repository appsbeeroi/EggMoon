import SwiftUI

struct SettingsView: View {
    
    @AppStorage(Constants.isNotificationSetup) var isNotificationSetup = false
    
    @Binding var isShowTabBar: Bool
    
    @State var selectedItem: SettingsCellItem?
    
    @State private var isNotificationEnable = false
    @State private var isShowNotificationAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigation
                cells
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            if let selectedItem,
               let url = URL(string: selectedItem.path) {
                WebView(url: url) {
                    self.selectedItem = nil
                    self.isShowTabBar = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
    }
    
    private var navigation: some View {
        Text("Settings")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .font(.system(size: 35, weight: .light))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    private var cells: some View {
        VStack(spacing: 8) {
            ForEach(SettingsCellItem.allCases) { item in
                Button {
                    guard item != .notifications else { return }
                    isShowTabBar = false
                    selectedItem = item
                } label: {
                    HStack {
                        Text(item.title)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 20, weight: .regular))
                            .foregroundStyle(.white)
                        
                        if item == .notifications {
                            Toggle(isOn: $isNotificationEnable) {}
                                .labelsHidden()
                        }
                    }
                    .frame(height: 60)
                    .padding(.horizontal)
                    .background(.white.opacity(0.12))
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.white.opacity(0.5), lineWidth: 1)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}

fileprivate enum Constants {
    static var isNotificationSetup = "isNotificationSetup"
}
