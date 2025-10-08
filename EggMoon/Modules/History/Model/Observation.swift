import Foundation

struct Observation: Codable, Identifiable, Equatable, Hashable {
    var id: UUID
    var date: Date
    var eggsCount: String
    var notes: String
    var chickOutup: ChickOutput?
    var phase: MoonPhase?
    
    var isLock: Bool {
        eggsCount == "" || notes == "" || chickOutup == nil 
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.date = Date()
        self.eggsCount = isMock ? "1" : ""
        self.notes = isMock ? "Test note" : ""
        self.chickOutup = isMock ? .successful : nil
        self.phase = isMock ? .firstQuarter : nil
    }
}
