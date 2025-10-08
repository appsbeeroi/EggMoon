import SwiftUI

struct WeatherConditionCellView: View {
    
    let condition: WeatherCondition
    
    var body: some View {
        VStack(spacing: 6) {
            Image(condition.image)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(condition.advice)
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
}
