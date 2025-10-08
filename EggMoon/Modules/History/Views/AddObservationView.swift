import SwiftUI

struct AddObservationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var observation: Observation
    
    let saveAction: (Observation) -> Void
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            GeometryReader { geo in
                VStack {
                    navigation
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 16) {
                            datePicker
                            egssCount
                            notes
                            chickOutput
                        }
                        .padding(.horizontal, 20)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Button("Done") {
                                        isFocused.toggle()
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                    
                    doneButton
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .ignoresSafeArea(.keyboard)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Circle()
                    .frame(width: 42, height: 42)
                    .foregroundStyle(.white.opacity(0.15))
                    .overlay {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
            
            Text("Add observations")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 35, weight: .light))
                .foregroundStyle(.white)
                .multilineTextAlignment(.leading)
        }
        .padding(.horizontal, 20)
    }
    
    private var datePicker: some View {
        DatePicker("", selection: $observation.date, displayedComponents: [.date])
            .labelsHidden()
            .datePickerStyle(.wheel)
            .colorScheme(.dark)
    }
    
    private var egssCount: some View {
        TextInputView(title: "Eggs count", keyboard: .numberPad, text: $observation.eggsCount, isFocused: $isFocused)
    }
    
    private var notes: some View {
        TextInputView(title: "Notes", keyboard: .default, text: $observation.notes, isFocused: $isFocused)
    }
    
    private var chickOutput: some View {
        VStack(spacing: 6) {
            Text("Chick output")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(.white)
            
            ChickOutputCellView(type: .successful, selectedOutput: $observation.chickOutup)
            ChickOutputCellView(type: .unsuccessful, selectedOutput: $observation.chickOutup)
        }
    }
    
    private var doneButton: some View {
        Button {
            saveAction(observation)
        } label: {
            Text("Done")
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .font(.system(size: 22, weight: .regular))
                .background(observation.isLock ? .emPink.opacity(0.25) : .emPink)
                .foregroundStyle(.emRed)
                .cornerRadius(20)
        }
        .padding(.horizontal, 20)
        .disabled(observation.isLock)
    }
}

#Preview {
    AddObservationView(observation: Observation(isMock: true)) { _ in }
}


