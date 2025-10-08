import SwiftUI


struct WeatherView: View {
    
    @Binding var isShowTabBar: Bool
    
    var tips: [String] {
        [
            "Ensure good ventilation in the coop to prevent dampness and respiratory issues.",
            "Replace bedding regularly to avoid mold and ammonia buildup.",
            "Avoid overcrowding to reduce stress and the risk of disease.",
            "Monitor humidity levels; consider using moisture-absorbing materials if necessary.",
            "Provide dry areas where chickens can rest comfortably."
        ]
    }
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigation
                cells
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
    }
    
    private var navigation: some View {
        Text("Weather & Care")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .font(.system(size: 35, weight: .light))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    private var cells: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                VStack(spacing: 6) {
                    Image(.Images.Weather.img6)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach(tips, id: \.self) { tip in
                        HStack {
                            Text("- ")
                            Text(tip)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .multilineTextAlignment(.leading)
                        }
                        .font(.system(size: 15, weight: .light))
                        .foregroundStyle(.white.opacity(0.5))

                    }
                }
                .padding(16)
                .background(.white.opacity(0.12))
                .cornerRadius(30)
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(.white.opacity(0.5), lineWidth: 1)
                }
                
                LazyVStack(spacing: 12) {
                    ForEach(WeatherCondition.allCases) { confition in
                        WeatherConditionCellView(condition: confition)
                    }
                }
            }
            .padding(.top, 2)
            .padding(.horizontal, 20)
        }
        .padding(.bottom, 100)
    }
}

#Preview {
    WeatherView(isShowTabBar: .constant(false))
}

