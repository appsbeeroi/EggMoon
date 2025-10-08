import SwiftUI

struct ObservationDetailView: View {
    
    @EnvironmentObject var viewModel: HistoryViewModel
    
    @State var observation: Observation
    
    let saveAction: (Observation) -> Void
    let removeAction: (Observation) -> Void
    
    @State private var isShowRemoveAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .resize()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        moon
                        date
                        status
                        notes
                    }
                    .padding(.horizontal, 20)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden()
        .alert("Are you sure you want to delete?", isPresented: $isShowRemoveAlert) {
            Button("Yes", role: .destructive) {
                removeAction(observation)
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    private var navigation: some View {
        HStack {
            Button {
                saveAction(observation)
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
            
            HStack(spacing: 20) {
                Button {
                    viewModel.navigationPath.append(.add(observation))
                } label: {
                    Text("Edit")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.blue)
                }
                
                Button {
                    isShowRemoveAlert.toggle()
                } label: {
                    Text("Delete")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(.red)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 20)
    }
    
    private var moon: some View {
        Image(observation.phase?.image ?? .Images.Weather.img1)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 200)
            .shadow(color: .white.opacity(0.5), radius: 10)
            .overlay {
                Text(observation.phase?.phase ?? "N/A")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(.white.opacity(0.45))
            }
    }
    
    private var date: some View {
        Text(observation.date.formatted(.dateTime.year().month(.twoDigits).day()))
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 40, weight: .light))
            .foregroundStyle(.white)
    }
    
    private var status: some View {
        HStack(spacing: 12) {
            VStack {
                Text("Eggs count")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.emGray)
                
                Spacer()
                
                Text(observation.eggsCount)
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(.white)
            }
            .padding(.vertical, 25)
            .frame(width: 136, height: 140)
            .background(.white.opacity(0.12))
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            }
            
            VStack {
                Text("Successful")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.emGray)
                
                Spacer()
                
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(observation.chickOutup == .successful ? .green : .red)
                    .overlay {
                        Image(systemName: observation.chickOutup == .successful ? "checkmark" : "multiply")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundStyle(.emRed)
                    }
            }
            .padding(.top, 20)
            .padding(.bottom, 25)
            .frame(width: 136, height: 140)
            .background(.white.opacity(0.12))
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            }
        }
    }
    
    private var notes: some View {
        VStack(spacing: 6) {
            Text("Notes")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.emGray)
            
            Text(observation.notes)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
        }
        .padding(10)
        .background(.white.opacity(0.12))
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.white.opacity(0.5), lineWidth: 1)
        }
    }
}

#Preview {
    ObservationDetailView(observation: Observation(isMock: true)) { _ in } removeAction: { _ in }
}
