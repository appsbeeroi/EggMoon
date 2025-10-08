import SwiftUI

struct TabMainView: View {
    
    @State private var selector: TabViewState = .calendar
    
    @State private var isShowtabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            tabView
            tabBar
        }
    }
    
    private var tabView: some View {
        TabView(selection: $selector) {
            CalendarView(isShowTabBar: $isShowtabBar)
                .toolbar(.hidden, for: .tabBar)
                .tag(TabViewState.calendar)
            
            RecommendationsView(isShowTabBar: $isShowtabBar)
                .toolbar(.hidden, for: .tabBar)
                .tag(TabViewState.recomanation)
            
            WeatherView(isShowTabBar: $isShowtabBar)
                .toolbar(.hidden, for: .tabBar)
                .tag(TabViewState.weather)
            
            HistoryView(isShowTabBar: $isShowtabBar)
                .toolbar(.hidden, for: .tabBar)
                .tag(TabViewState.history)
            
            SettingsView(isShowTabBar: $isShowtabBar)
                .toolbar(.hidden, for: .tabBar)
                .tag(TabViewState.settings)
        }
    }
    
    private var tabBar: some View {
        VStack {
            HStack(spacing: 6) {
                ForEach(TabViewState.allCases) { state in
                    Button {
                        selector = state
                    } label: {
                        Circle()
                            .frame(width: 61, height: 61)
                            .foregroundStyle(selector == state ? .emPink : .white.opacity(0.2))
                            .overlay {
                                Image(state.icon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 28, height: 28)
                            }
                    }
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(.white.opacity(0.3))
            .cornerRadius(94)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .opacity(isShowtabBar ? 1 : 0)
    }
}

#Preview {
    TabMainView()
}
