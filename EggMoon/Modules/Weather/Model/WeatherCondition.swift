import UIKit

enum WeatherCondition: Identifiable, CaseIterable {
    var id: Self { self }
    
    case sunny
    case rain
    case thunderstorm
    case snow
    case fog
    
    var image: ImageResource {
        switch self {
            case .sunny: return .Images.Weather.img1
            case .rain: return .Images.Weather.img2
            case .thunderstorm: return .Images.Weather.img3
            case .snow: return .Images.Weather.img4
            case .fog: return .Images.Weather.img5
        }
    }
    
    var advice: String {
        switch self {
            case .sunny:
                return "Provide shade and fresh water, ensure proper ventilation in the coop. Avoid overheating by limiting sun exposure during peak hours."
            case .rain:
                return "Protect the coop from water, replace wet bedding, and monitor humidity levels. Ensure drainage around the coop to prevent puddles."
            case .thunderstorm:
                return "Keep chickens indoors, secure the coop, and ensure there is no risk of flooding. Avoid using electrical equipment during storms."
            case .snow:
                return "Insulate the coop, add extra bedding, and provide warm water to prevent freezing. Check for drafts and keep chickens dry."
            case .fog:
                return "Monitor humidity inside the coop and ensure adequate ventilation to prevent dampness. Avoid overcrowding to reduce risk of respiratory issues."
        }
    }
}
