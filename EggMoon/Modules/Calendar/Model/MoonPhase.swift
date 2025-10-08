import UIKit

enum MoonPhase: Codable {
    case newMoon
    case waxingCrescent
    case firstQuarter
    case waxingGibbous
    case fullMoon
    case waningGibbous
    case lastQuarter
    case waningCrescent
    
    var image: ImageResource {
        switch self {
            case .newMoon: return .Images.Calendar.img1
            case .waxingCrescent: return .Images.Calendar.img2
            case .firstQuarter: return .Images.Calendar.img3
            case .waxingGibbous: return .Images.Calendar.img4
            case .fullMoon: return .Images.Calendar.img5
            case .waningGibbous: return .Images.Calendar.img6
            case .lastQuarter: return .Images.Calendar.img7
            case .waningCrescent: return .Images.Calendar.img8
        }
    }
    
    var phase: String {
        switch self {
            case .newMoon: return "New Moon"
            case .waxingCrescent: return "Waxing Crescent"
            case .firstQuarter: return "First Quarter"
            case .waxingGibbous: return "Waxing Gibbous"
            case .fullMoon: return "Full Moon"
            case .waningGibbous: return "Waning Gibbous"
            case .lastQuarter: return "Last Quarter"
            case .waningCrescent: return "Waning Crescent"
        }
    }
    
    var recommendation: String {
        switch self {
            case .newMoon:
                return "Best time to set eggs in the incubator — high chick survival rate."
            case .waxingCrescent:
                return "Good period to start new processes on the farm. Keep the feeding balanced."
            case .firstQuarter:
                return "Egg production increases. Add more protein and calcium to the diet."
            case .waxingGibbous:
                return "Peak activity of the flock. Provide fresh water and keep bedding clean."
            case .fullMoon:
                return "Egg production may drop. Supplement with vitamins to support immunity."
            case .waningGibbous:
                return "Birds may become restless. Ensure calm and stable housing conditions."
            case .lastQuarter:
                return "Good time for cleaning, disinfection, and disease prevention measures."
            case .waningCrescent:
                return "Energy levels decrease. Reduce stress, provide rest and comfort."
        }
    }
}
