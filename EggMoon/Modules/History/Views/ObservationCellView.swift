import SwiftUI

struct ObservationCellView: View {
    
    let observation: Observation
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 6) {
                HStack {
                    Image(observation.phase?.image ?? .Images.Weather.img1)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .shadow(color: .white.opacity(0.5), radius: 10)
                    
                    Text(observation.date.formatted(.dateTime.year().month(.twoDigits).day()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 22, weight: .light))
                        .foregroundStyle(.white)
                }
                
                HStack {
                    VStack(spacing: 6) {
                        Text("Eggs count")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.emGray)
                        
                        Text(observation.eggsCount)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    .frame(width: 84, height: 38, alignment: .top)
                    
                    VStack(spacing: 6) {
                        Text("Successful")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.emGray)
                        
                        Circle()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(observation.chickOutup == .successful ? .green : .red)
                            .overlay {
                                Image(systemName: observation.chickOutup == .successful ? "checkmark" : "multiply")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                    }
                    .frame(width: 84, height: 38, alignment: .top)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .background(.white.opacity(0.12))
            .cornerRadius(30)
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            }
        }
    }
}
