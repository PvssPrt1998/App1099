import SwiftUI

struct FinanceCard: View {
    
    let finance: Finance
    
    var body: some View {
        VStack(spacing: 5) {
            Text(finance.name)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack(spacing: 44) {
                Text(finance.benefit)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                Text(finance.promotion)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(EdgeInsets(top: 35, leading: 15, bottom: 10, trailing: 15))
        .background(Color.white)
        .overlay(
            Rectangle()
                .fill(Color.headerBg)
                .frame(height: 35)
                .overlay(
                    Text(finance.price)
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.headerText)
                )
            ,alignment: .top
        )
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    FinanceCard(finance: Finance(uuid: UUID(), name: "Name", price: "Price", benefit: "Benefit", promotion: "Promotion"))
        .padding()
        .background(Color.bgCon)
}
