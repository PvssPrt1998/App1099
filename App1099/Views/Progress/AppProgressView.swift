import SwiftUI

struct AppProgressView: View {
    
    @EnvironmentObject var source: Source
    
    @State var addSheet = false
    @State var editSheet = false
    
    var body: some View {
        ZStack {
            Color.headerBg.ignoresSafeArea()
            Color.bgCon
            
            VStack(spacing: 0) {
                Text("Progress")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.headerText)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.headerBg)
                
                if source.progresses.isEmpty {
                    emptyView
                } else {
                    progressList
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
            AddProgress(show: $addSheet)
        })
        .sheet(isPresented: $editSheet, content: {
            EditProgress(show: $editSheet, progress: source.progressForEdit!)
        })
    }
    
    private var progressList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(0..<source.progresses.count, id: \.self) { index in
                    ProgressCard(progress: source.progresses[index]) {
                        source.decrement(by: index)
                    } increment: {
                        source.increment(by: index)
                    } action: {
                        source.progressForEdit = source.progresses[index]
                        editSheet = true
                    }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 88, trailing: 20))
        }
        
    }
    
    private var emptyView: some View {
        ZStack {
            Text("Fill in progress data -\nthis is a useful feature")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 420, trailing: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            Image("ProgressArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 39, height: 371)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 103, trailing: 32))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            Image("ProgressGuys")
                .resizable()
                .scaledToFit()
                .frame(width: 301, height: 277)
                .padding(.leading, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        }
    }
}

#Preview {
    AppProgressView()
        .environmentObject(Source())
}
