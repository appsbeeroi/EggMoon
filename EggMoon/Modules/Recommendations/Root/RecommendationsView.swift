import SwiftUI

struct RecommendationsView: View {
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedCategory: PoultryRecommendationCategory = .feeding
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        categorySelector
                        recommendations
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 100)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.easeOut, value: selectedCategory)
        }
    }
    
    private var navigation: some View {
        Text("Recommendations for\npoultry farmers")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 16)
            .padding(.horizontal, 20)
            .font(.system(size: 35, weight: .light))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
    private var categorySelector: some View {
        HStack(spacing: 6) {
            ForEach(PoultryRecommendationCategory.allCases) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category.title)
                        .frame(height: 32)
                        .padding(.horizontal, 10)
                        .font(.system(size: 12, weight: selectedCategory == category ? .heavy : .light))
                        .foregroundStyle(.white)
                        .background(selectedCategory == category ? .emPink : .white.opacity(0.12))
                        .cornerRadius(12)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var recommendations: some View {
        LazyVStack(spacing: 8) {
            ForEach(selectedCategory.recommendations) { recommendation in
                RecommendationCellView(recommendation: recommendation)
            }
        }
    }
}

#Preview {
    RecommendationsView(isShowTabBar: .constant(false))
}
