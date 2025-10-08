import SwiftUI

struct ChickOutputCellView: View {
    
    let type: ChickOutput
    
    @Binding var selectedOutput: ChickOutput?
    
    var body: some View {
        Button {
            selectedOutput = type
        } label: {
            HStack(spacing: 6) {
                Circle()
                    .stroke(.emPink, lineWidth: 1)
                    .frame(width: 25, height: 25)
                    .overlay {
                        if selectedOutput == type {
                            Circle()
                                .frame(width: 14, height: 14)
                                .foregroundStyle(.emPink)
                        }
                    }
                
                Text(type.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.white)
            }
            .frame(height: 65)
            .padding(.horizontal, 10)
            .background(.white.opacity(0.12))
            .cornerRadius(20)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white.opacity(0.5), lineWidth: 2)
            }
        }
    }
}
