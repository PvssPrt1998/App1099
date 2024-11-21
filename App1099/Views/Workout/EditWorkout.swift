import SwiftUI

struct EditWorkout: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var sport: String
    @State var date: String
    @State var time: String
    @State var visits: String
    @State var tag: String
    
    init(show: Binding<Bool>, workout: Workout) {
        self._show = show
        sport = workout.sport
        date = workout.date
        time = workout.time
        visits = workout.visits
        tag = workout.tag
    }
    
    var body: some View {
        ZStack {
            Color.contentBg.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 8)
                    .background(Color.white)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                    }
                ScrollView(.vertical, showsIndicators: false) {
                    content
                        .padding(.bottom, 10)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            
            ZStack {
                VStack(spacing: 5) {
                    Text("You have a good\nworkout, keep it up")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.headerBg)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Image("WorkoutCurveLine2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 116,height: 51)
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)
                
                Image("WorkoutGirl")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 143)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    
            }
            .frame(width: 282, height: 175)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea(.keyboard)
            
        }
    }
    
    private var header: some View {
        VStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.c606067.opacity(0.3))
                .frame(width: 36, height: 5)
                .padding(.top, 5)
            HStack {
                Button {
                    show = false
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 17, weight: .semibold))
                        
                        Text("Back")
                            .font(.system(size: 17, weight: .regular))
                    }
                    .padding(.horizontal, 8)
                }
                Spacer()
                Button {
                    source.editWorkout(sport: sport, date: date, time: time, visits: visits, tag: tag)
                    show = false
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .regular))
                }
                .disabled(disabled)
                .padding(.horizontal, 8)
            }
            .frame(height: 44)
            
            Text("Workout")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.black)
                .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(height: 0.33)
        }
    }
    
    private var disabled: Bool {
        sport == "" || date.count < 10 || time == "" || visits == "" || tag == ""
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Text("You can edit your\ndetails")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
            
            VStack(spacing: 0) {
                TextFieldCustom(text: $sport, prefix: "Sport", placeholder: "Name of sport")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $date, prefix: "Date", placeholder: "Date of your training")
                    .keyboardType(.numberPad)
                    .onChange(of: date, perform: { newValue in
                        dateValidation(newValue)
                    })
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $time, prefix: "Time", placeholder: "Training time")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $visits, prefix: "Visits", placeholder: "Number of visits")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $tag, prefix: "Tag", placeholder: "Tag name")
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 26)
            .padding(.top, 28)
        }
        .padding(.top, 29)
    }
    
    private func dateValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            var filterIterable = filtered.makeIterator()
            var index = 0
            var value = ""
            while let c = filterIterable.next() {
                if index == 0 || index == 1 || index == 3 || index == 5 || index == 6 || index == 7 {
                    value = value + "\(c)"
                }
                if index == 2 || index == 4 {
                    value = value + ".\(c)"
                }
                index += 1
            }
            date = value
        } else  {
            date = ""
        }
    }
}

struct EditWorkout_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        EditWorkout(show: $show, workout: Workout(uuid: UUID(), sport: "Sport", date: "11.11.2222", time: "Time", visits: "Visits", tag: "Tag"))
            .environmentObject(Source())
    }
}
