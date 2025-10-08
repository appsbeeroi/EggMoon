import UIKit

enum TabViewState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case calendar
    case recomanation
    case weather
    case history
    case settings
    
    var icon: ImageResource {
        switch self {
            case .calendar:
                    .Icons.Tab.calendar
            case .recomanation:
                    .Icons.Tab.recomendations
            case .weather:
                    .Icons.Tab.weather
            case .history:
                    .Icons.Tab.history
            case .settings:
                    .Icons.Tab.settings
        }
    }
}
