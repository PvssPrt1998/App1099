import SwiftUI

struct AccountingView: View {
    
    @EnvironmentObject var source: Source
    
    @State var addSheet = false
    @State var editSheet = false
    
    var body: some View {
        ZStack {
            Color.headerBg.ignoresSafeArea()
            Color.contentBg
            
            VStack(spacing: 0) {
                Text("Financial accounting")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.headerText)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.headerBg)
                
                if source.finances.isEmpty {
                    emptyView
                } else {
                    financeList
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
            AddFinance(show: $addSheet)
        })
        .sheet(isPresented: $editSheet, content: {
            EditFinance(show: $editSheet, finance: source.financeForEdit!)
        })
    }
    
    private var financeList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(source.finances, id: \.self) { finance in
                    FinanceCard(finance: finance)
                        .onTapGesture {
                            source.financeForEdit = finance
                            editSheet = true
                        }
                }
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 90, trailing: 20))
        }
    }
    
    private var emptyView: some View {
        ZStack {
            Text("Add results about your\nfinances")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 390, trailing: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            Image("AccountingArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 336)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 103, trailing: 25))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            Image("AccountingImage")
                .resizable()
                .scaledToFit()
                .frame(width: 254, height: 239)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    AccountingView()
        .environmentObject(Source())
}
