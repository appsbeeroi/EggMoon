enum ChickOutput: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case successful
    case unsuccessful
    
    var title: String {
        switch self {
            case .successful:
                "Successful"
            case .unsuccessful:
                "Unsucessful"
        }
    }
}
