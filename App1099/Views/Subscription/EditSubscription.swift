import SwiftUI

struct EditSubscription: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var name: String
    @State var startDate: String
    @State var endDate: String
    @State var visits: String
    @State var price: String
    @State var type: String
    
    init(show: Binding<Bool>, subscription: Subscription) {
        self._show = show
        name = subscription.name
        startDate = subscription.startDate
        endDate = subscription.endDate
        visits = subscription.visits
        price = subscription.price
        type = subscription.type
    }
    
    var body: some View {
        ZStack {
            Color.bgCon.ignoresSafeArea()
            VStack(spacing: 0) {
                header
                    .padding(.horizontal, 8)
                    .background(Color.white)
                ScrollView(.vertical, showsIndicators: false) {
                    content
                        .padding(.bottom, 10)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Image("SubscriptionGuys")
                .resizable()
                .scaledToFit()
                .frame(height: 130)
                .frame(maxHeight: .infinity, alignment: .bottom)
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
                    source.editSubscription(name: name, startDate: startDate, endDate: endDate, visits: visits, price: price, type: type)
                    show = false
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .regular))
                }
                .disabled(disabled)
                .padding(.horizontal, 8)
            }
            .frame(height: 44)
            
            Text("My subscriptions")
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
        name == "" || startDate.count < 10 || endDate.count < 10 || visits == "" || price == "" || type == ""
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Text("You can edit your\ndetails")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 0) {
                TextFieldCustom(text: $name, prefix: "Name", placeholder: "Fitness, pool, sport center")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $startDate, prefix: "Start date", placeholder: "Start date of training")
                    .keyboardType(.numberPad)
                    .onChange(of: startDate, perform: { newValue in
                        startDateValidation(newValue)
                    })
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $endDate, prefix: "End date", placeholder: "Enter date of training")
                    .keyboardType(.numberPad)
                    .onChange(of: endDate, perform: { newValue in
                        endDateValidation(newValue)
                    })
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $visits, prefix: "Visits", placeholder: "Number of visits")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $price, prefix: "Price", placeholder: "Subscription price")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $type, prefix: "Type", placeholder: "One-time, monthly, annual")
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 26)
            .padding(.top, 28)
        }
        .padding(.top, 29)
    }
    
    private func startDateValidation(_ newValue: String) {
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
            startDate = value
        } else  {
            startDate = ""
        }
    }
    
    private func endDateValidation(_ newValue: String) {
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
            endDate = value
        } else  {
            endDate = ""
        }
    }
}

struct EditSubscription_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        EditSubscription(show: $show, subscription: Subscription(uuid: UUID(), name: "name", startDate: "11.11.1111", endDate: "11.12.2222", visits: "visits", price: "price", type: "type"))
            .environmentObject(Source())
    }
}
