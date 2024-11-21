import SwiftUI

struct SubscriptionView: View {
    
    @EnvironmentObject var source: Source
    
    @State var addSheet = false
    @State var editSheet = false
    
    var body: some View {
        ZStack {
            Color.headerBg.ignoresSafeArea()
            Color.contentBg
            
            VStack(spacing: 0) {
                Text("My subscriptions")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.headerText)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.headerBg)
                
                if source.subscriptions.isEmpty {
                    emptyView
                } else {
                    subscriptionsList
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
            AddSubscription(show: $addSheet)
        })
        .sheet(isPresented: $editSheet, content: {
            EditSubscription(show: $editSheet, subscription: source.subscriptionForEdit!)
        })
    }
    
    private var emptyView: some View {
        VStack {
            VStack(spacing: 31) {
                Text("😢")
                    .font(.system(size: 96, weight: .regular))
                Text("Add information about\nyour subscriptions")
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(.headerBg)
                    .multilineTextAlignment(.center)
            }
            .frame(maxHeight: .infinity)
            Image("SubscriptionArrow")
                .resizable()
                .scaledToFit()
                .frame(width: 198, height: 226)
                .padding(.leading, 120)
        }
        .padding(.bottom, 75)
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
    
    private var subscriptionsList: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 20) {
                ForEach(source.subscriptions, id: \.self) { subscription in
                    subscriptionCard(subscription)
                        .onTapGesture {
                            source.subscriptionForEdit = subscription
                            editSheet = true
                        }
                }
            }
            .padding(EdgeInsets(top: 24, leading: 20, bottom: 24, trailing: 20))
        }
    }
    
    func subscriptionCard(_ subscription: Subscription) -> some View {
        VStack(spacing: 5) {
            HStack {
                Text(subscription.name)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(subscription.startDate + "-" + subscription.endDate)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 15))
            
            HStack(spacing: 20) {
                Text(subscription.visits)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                Text(subscription.price)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                Text(subscription.type)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 1, trailing: 15))
            .frame(maxWidth: .infinity, alignment: .leading)
            Rectangle()
                .fill(Color.headerBg)
                .frame(height: 29)
        }
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    SubscriptionView()
        .environmentObject(Source())
}
