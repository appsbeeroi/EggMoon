import UserNotifications

enum PushPermissionStatus {
    case granted
    case denied
    case notRequested
}

final class PushPermissionService {
    
    static let shared = PushPermissionService()
    
    private init() {}
    
    var status: PushPermissionStatus {
        get async {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()
            
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                return .granted
            case .denied:
                return .denied
            case .notDetermined:
                return .notRequested
            @unknown default:
                return .denied
            }
        }
    }
    
    @discardableResult
    func requestPermission() async -> Bool {
        do {
            let center = UNUserNotificationCenter.current()
            let isGranted = try await center.requestAuthorization(options: [.alert, .badge, .sound])
            return isGranted
        } catch {
            print("⚠️ Push permission request failed: \(error.localizedDescription)")
            return false
        }
    }
}
