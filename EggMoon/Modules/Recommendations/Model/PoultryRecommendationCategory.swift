enum PoultryRecommendationCategory: Identifiable, CaseIterable {
    var id: Self { self }
    
    case feeding
    case care
    case eggProduction
    case reminders
    
    var title: String {
        switch self {
            case .feeding:
                "Feeding"
            case .care:
                "Care"
            case .eggProduction:
                "Egg production"
            case .reminders:
                "Reminder"
        }
    }
    
    var recommendations: [PoultryRecommendation] {
        switch self {
            case .feeding:
                return [
                    PoultryRecommendation(
                        phase: .newMoon,
                        description: "Increase vitamins and minerals to strengthen immunity."
                    ),
                    PoultryRecommendation(
                        phase: .firstQuarter,
                        description: "Add more protein for active growth and strengthening of birds."
                                         ),
                    PoultryRecommendation(
                        phase: .fullMoon,
                        description: "Balanced diet with emphasis on calcium for eggshell quality."
                    ),
                    PoultryRecommendation(
                        phase: .lastQuarter,
                        description: "Reduce concentrates, add more greens to the diet."
                    )
                ]
                
            case .care:
                return [
                    PoultryRecommendation(
                        phase: .newMoon,
                        description: "Provide a calm environment, minimize stress."
                    ),
                    PoultryRecommendation(
                        phase: .firstQuarter,
                        description: "Ensure access to fresh air and outdoor walks."
                    ),
                    PoultryRecommendation(
                        phase: .fullMoon,
                        description: "Pay attention to lighting in the poultry house, avoid overworking birds."
                    ),
                    PoultryRecommendation(
                        phase: .lastQuarter,
                        description: "Focus on cleanliness and disinfection."
                    )
                ]
                
            case .eggProduction:
                return [
                    PoultryRecommendation(
                        phase: .newMoon,
                        description: "May decrease, additional lighting is recommended."
                    ),
                    PoultryRecommendation(
                        phase: .firstQuarter,
                        description: "Gradual increase in egg production."
                    ),
                    PoultryRecommendation(
                        phase: .fullMoon,
                        description: "Peak egg production, maximum activity."
                    ),
                    PoultryRecommendation(
                        phase: .lastQuarter,
                        description: "Decrease in egg production observed."
                    )
                ]
                
            case .reminders:
                return [
                    PoultryRecommendation(
                        phase: .newMoon,
                        description: "Check feeders and drinkers, carry out cleaning."
                    ),
                    PoultryRecommendation(
                        phase: .firstQuarter,
                        description: "Monitor feathers and claws, refresh bedding."
                    ),
                    PoultryRecommendation(
                        phase: .fullMoon,
                        description: "Collect and check eggs for quality, conduct parasite prevention."
                    ),
                    PoultryRecommendation(
                        phase: .lastQuarter,
                        description: "Assess birds' overall health, prepare for the next cycle."
                    )
                ]
        }
    }
}
