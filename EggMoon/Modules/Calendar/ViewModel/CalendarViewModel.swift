import Foundation
import Combine

final class CalendarViewModel: ObservableObject {
    
    private let moonPhaseCalculator = MoonPhaseCalculator()
    
    @Published var selectedDate = Date()
    @Published private(set) var todayMoonPhase: MoonPhase?
    
    private var anyCanceller: AnyCancellable?
    
    init() {
        observeSelectedDate()
    }
    
    private func observeSelectedDate() {
        anyCanceller = $selectedDate
            .sink { [weak self] date in
                guard let self else { return }
                self.todayMoonPhase = self.moonPhaseCalculator.phase(for: date)
            }
    }
}
