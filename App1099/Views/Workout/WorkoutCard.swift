import SwiftUI

struct WorkoutCard: View {
    
    let workout: Workout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(workout.date)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            Text(workout.time)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            Text(workout.visits)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 77, leading: 13, bottom: 18, trailing: 13))
        .frame(width: 148)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.headerBg, lineWidth: 3)
        )
        .overlay(
            Text(workout.sport)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 10, leading: 13, bottom: 10, trailing: 13))
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 64)
                .background(Color.headerText)
            ,alignment: .topLeading
        )
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    WorkoutCard(workout: Workout(uuid: UUID(), sport: "Sport", date: "11.11.1111", time: "time", visits: "visits", tag: "tag"))
        .padding()
        .background(Color.bgCon)
}
