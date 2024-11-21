import SwiftUI

struct WorkoutView: View {
    
    @EnvironmentObject var source: Source
    
    @State var addSheet = false
    @State var editSheet = false
    
    var body: some View {
        ZStack {
            Color.headerBg.ignoresSafeArea()
            Color.bgCon
            
            VStack(spacing: 0) {
                Text("Workout")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.headerText)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.headerBg)
                
                if source.workouts.isEmpty {
                    emptyView
                } else {
                    workoutsGrid
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Button {
                addSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.c0122255)
                    .clipShape(.circle)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
        .sheet(isPresented: $addSheet, content: {
            AddWorkout(show: $addSheet)
        })
        .sheet(isPresented: $editSheet, content: {
            EditWorkout(show: $editSheet, workout: source.workoutForEdit!)
        })
    }
    
    private var workoutsGrid: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 26) {
                ForEach(workoutTags, id: \.self) { tag in
                    VStack(spacing: 10) {
                        Text(tag)
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LazyVGrid(columns: [GridItem(.fixed(148), spacing: 30),GridItem(.fixed(148))], spacing: 10) {
                            ForEach(source.workouts.filter({$0.tag == tag}), id: \.self) { workout in
                                WorkoutCard(workout: workout)
                                    .onTapGesture {
                                        source.workoutForEdit = workout
                                        editSheet = true
                                    }
                            }
                        }
                    }
                }
            }
            .padding(EdgeInsets(top: 25, leading: 31, bottom: 88, trailing: 31))
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text("I think it's time to fill\nout your training\ndata.\nClick on the button")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
            Image("WorkoutCurveLine")
                .resizable()
                .scaledToFit()
                .frame(width: 112, height: 136)
                .padding(.leading, 80)
            Image("WorkoutGuy")
                .resizable()
                .scaledToFit()
                .frame(width: 124, height: 248)
                .padding(.leading, 170)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    var workoutTags: Array<String> {
        var array: Array<String> = []
        source.workouts.forEach { workout in
            if !array.contains(workout.tag) {
                array.append(workout.tag)
            }
        }
        return array
    }
}

#Preview {
    WorkoutView()
        .environmentObject(Source())
}
