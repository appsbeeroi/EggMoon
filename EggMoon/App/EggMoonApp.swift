import SwiftUI

@main
struct EggMoonApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await PushPermissionService.shared.requestPermission()
                    }
                }
        }
    }
}
