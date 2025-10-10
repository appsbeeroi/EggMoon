import SwiftUI

struct SplashScreen: View {
    
    @Binding var isMainSwitchedOn: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            Text("EggsMoon")
                .foregroundStyle(.white)
                .font(.system(size: 60, weight: .light))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isMainSwitchedOn = true
            }
        }
    }
}

#Preview {
    SplashScreen(isMainSwitchedOn: .constant(false))
}
