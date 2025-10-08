import SwiftUI

struct ContentView: View {
    
    @State private var isMainSwitchedOn = false
    
    var body: some View {
        if isMainSwitchedOn {
            TabMainView()
        } else {
            SplashScreen(isMainSwitchedOn: $isMainSwitchedOn)
        }
    }
}

#Preview {
    ContentView()
}



