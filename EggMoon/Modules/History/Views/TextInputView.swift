import SwiftUI

struct TextInputView: View {
    
    let title: String
    let keyboard: UIKeyboardType
    
    @Binding var text: String
    
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.emGray)
            
            HStack {
                TextField("", text: $text, prompt: Text("Enter text...")
                    .foregroundColor(.emGray)
                )
                .keyboardType(keyboard)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .focused($isFocused)
                
                if text != "" {
                    Button {
                        isFocused = false
                        text = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.emGray)
                    }
                }
            }
        }
        .padding(10)
        .background(.white.opacity(0.12))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.5), lineWidth: 2)
        }
    }
}
