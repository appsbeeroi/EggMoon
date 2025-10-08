import SwiftUI

final class HistoryViewModel: ObservableObject {
    
    private let defaultsService = DefaultsService.shared
    
    @Published var navigationPath: [HistoryScreen] = []
    
    @Published private(set) var observations: [Observation] = [Observation(isMock: true), Observation(isMock: true), Observation(isMock: true)]
    
    func loadObservations() {
        Task { [weak self] in
            guard let self else { return }
            
            let observationsUD = await self.defaultsService.retrieve([Observation].self, for: .observation) ?? []
            
            await MainActor.run {
                self.observations = observationsUD
            }
        }
    }
    
    func save(_ observation: Observation) {
        Task { [weak self] in
            guard let self else { return }
            
            var observationsUD = await defaultsService.retrieve([Observation].self, for: .observation) ?? []
            
            if let index = observationsUD.firstIndex(where: { $0.id == observation.id }) {
                observationsUD[index] = observation
            } else {
                observationsUD.append(observation)
            }
            
            await self.defaultsService.store(observationsUD, for: .observation)
            
            await MainActor.run {
                if let index = self.observations.firstIndex(where: { $0.id == observation.id }) {
                    self.observations[index] = observation
                } else {
                    self.observations.append(observation)
                }
                
                self.navigationPath.removeAll()
            }
        }
    }
    
    func remove(_ observation: Observation) {
        Task { [weak self] in
            guard let self else { return }
            
            var observationsUD = await defaultsService.retrieve([Observation].self, for: .observation) ?? []
            
            if let index = observationsUD.firstIndex(where: { $0.id == observation.id }) {
                observationsUD.remove(at: index)
            }
            
            await self.defaultsService.store(observationsUD, for: .observation)
            
            await MainActor.run {
                if let index = self.observations.firstIndex(where: { $0.id == observation.id }) {
                    self.observations.remove(at: index)
                }
                
                self.navigationPath.removeAll()
            }
        }
    }
}
