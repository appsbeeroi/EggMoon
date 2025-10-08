import Foundation

final class MoonPhaseCalculator {
    
    private let referenceNewMoon: Date = {
        var components = DateComponents()
        components.year = 2000
        components.month = 1
        components.day = 6
        components.hour = 18
        components.minute = 14
        return Calendar.current.date(from: components)!
    }()
    
    private let lunarCycle: Double = 29.53
    
    func phase(for date: Date) -> MoonPhase {
        let daysSinceReference = daysBetween(referenceNewMoon, date)
        let cyclePosition = daysSinceReference.truncatingRemainder(dividingBy: lunarCycle)
        let fraction = cyclePosition / lunarCycle
        
        switch fraction {
        case 0.0..<0.125:
            return .newMoon
        case 0.125..<0.25:
            return .waxingCrescent
        case 0.25..<0.375:
            return .firstQuarter
        case 0.375..<0.5:
            return .waxingGibbous
        case 0.5..<0.625:
            return .fullMoon
        case 0.625..<0.75:
            return .waningGibbous
        case 0.75..<0.875:
            return .lastQuarter
        default:
            return .waningCrescent
        }
    }
    
    private func daysBetween(_ from: Date, _ to: Date) -> Double {
        let interval = to.timeIntervalSince(from)
        return interval / (60 * 60 * 24)
    }
}
