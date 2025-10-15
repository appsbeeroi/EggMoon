import SwiftUI

struct SplashScreen: View {
    
    @Binding var isMainSwitchedOn: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                Text("EggsMoon")
                    .foregroundStyle(.white)
                    .font(.system(size: 60, weight: .light))
                
                ProgressView()
                    .scaleEffect(1.5)
                    .tint(.white)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
            withAnimation {
                isMainSwitchedOn = true
            }
        }
    }
}

#Preview {
    SplashScreen(isMainSwitchedOn: .constant(false))
}
