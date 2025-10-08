import SwiftUI

struct RecommendationCellView: View {
    
    let recommendation: PoultryRecommendation
    
    var body: some View {
        VStack {
            Image(recommendation.phase.image)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .shadow(color: .white.opacity(0.5), radius: 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(recommendation.phase.phase)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 22, weight: .light))
                .foregroundStyle(.white)
            
            Text(recommendation.description)
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
