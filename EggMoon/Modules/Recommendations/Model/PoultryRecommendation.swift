import Foundation

struct PoultryRecommendation: Identifiable {
    var id: UUID = UUID()
    let phase: MoonPhase
    let description: String
}


