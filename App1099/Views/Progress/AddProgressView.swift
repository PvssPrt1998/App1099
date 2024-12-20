import SwiftUI

struct AddProgress: View {
    
    @EnvironmentObject var source: Source
    @Binding var show: Bool
    
    @State var name = ""
    @State var description = ""
    @State var unit = ""
    @State var quantity = ""
    
    var body: some View {
        ZStack {
            Color.bgCon.ignoresSafeArea()
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
            
            Image("ProgressGuys2")
                .resizable()
                .scaledToFit()
                .frame(width: 253, height: 225)
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
                    source.saveProgress(name: name, description: description, unit: unit, totalQuantity: quantity)
                    show = false
                } label: {
                    Text("Done")
                        .font(.system(size: 17, weight: .regular))
                }
                .disabled(disabled)
                .padding(.horizontal, 8)
            }
            .frame(height: 44)
            
            Text("Progress")
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
        name == "" || description == "" || unit == "" || quantity == ""
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            Text("Fill in your progress\ndetails")
                .font(.system(size: 28, weight: .regular))
                .foregroundColor(.headerBg)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                }
            
            VStack(spacing: 0) {
                TextFieldCustom(text: $name, prefix: "Name", placeholder: "Name of sport")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $description, prefix: "Description", placeholder: "Description of the sport")
                    
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $unit, prefix: "Unit", placeholder: "Training time")
                Divider()
                    .padding(.leading, 16)
                TextFieldCustom(text: $quantity, prefix: "Quantity", placeholder: "Number of visits")
                    .keyboardType(.numberPad)
                    .onChange(of: quantity, perform: { newValue in
                        quantityValidation(newValue)
                    })
            }
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 10))
            .padding(.horizontal, 26)
            .padding(.top, 28)
        }
        .padding(.top, 29)
    }
    
    private func quantityValidation(_ newValue: String) {
        let filtered = newValue.filter { Set("0123456789").contains($0) }
        
        if filtered != "" {
            quantity = filtered
        } else  {
            quantity = ""
        }
    }
}

struct AddProgress_Preview: PreviewProvider {
    
    @State static var show = true
    
    static var previews: some View {
        AddProgress(show: $show)
            .environmentObject(Source())
    }
}
