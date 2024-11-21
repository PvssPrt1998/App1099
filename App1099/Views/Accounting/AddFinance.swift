import SwiftUI

struct AddFinance: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var name = ""
    @State var price = ""
    @State var benefit = ""
    @State var promotion = ""
    
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
            
            Image("AccountingImage2")
                .resizable()
                .scaledToFit()
                .frame(height: 211)
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
                    source.saveFinance(name: name, price: price, benefit: benefit, promotion: promotion)
                    show = false
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .regular))
                }
                .disabled(disabled)
                .padding(.horizontal, 8)
            }
            .frame(height: 44)
            
            Text("Finance")
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
        name == "" || price == "" || benefit == "" || promotion == ""
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Text("Enter financial\ninformation")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
            
            VStack(spacing: 0) {
                TextFieldCustom(text: $name, prefix: "Name", placeholder: "Fitness gym, pool")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $price, prefix: "Price", placeholder: "Total cost")
                    
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $benefit, prefix: "Benefit", placeholder: "Cost benefit")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $promotion, prefix: "Promotion", placeholder: "Promotions or discounts")
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 26)
            .padding(.top, 28)
        }
        .padding(.top, 29)
    }
}

struct AddFinance_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        AddFinance(show: $show)
            .environmentObject(Source())
    }
}
