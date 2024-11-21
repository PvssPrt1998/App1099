import SwiftUI

struct ProgressCard: View {
    
    let progress: Progress
    let decrement: () -> Void
    let increment: () -> Void
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(progress.name)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(.headerText)
                    .frame(width: 184, height: 49)
                    .background(Color.headerBg)
                    .cornerRadius(10, corners: [.topLeft, .bottomRight, .bottomLeft])
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                Text("\(progress.quantity)/\(progress.totalQuantity) " + progress.unit)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.black)
                    .frame(width: 94, height: 32)
                    .padding(.trailing, 15)
            }
            .onTapGesture {
                action()
            }
            
            HStack(spacing: 0) {
                Text(progress.description)
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.black)
                    .frame(width: 184)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .onTapGesture {
                        action()
                    }
                
                HStack(spacing: 0) {
                    Button {
                        decrement()
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .disabled(progress.quantity <= 0)
                    .opacity(progress.quantity <= 0 ? 0.5 : 1)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.c606067.opacity(0.3))
                        .frame(width: 1, height: 18)
                    
                    Button {
                        increment()
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 17, weight: .regular))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .disabled(progress.totalQuantity <= progress.quantity)
                    .opacity(progress.totalQuantity <= progress.quantity ? 0.5 : 1)
                }
                .frame(width: 94, height: 32)
                .background(Color.c120120120.opacity(0.12))
                .clipShape(.rect(cornerRadius: 8))
                .padding(.trailing, 15)
            }
            .frame(maxHeight: .infinity)
        }
        .frame(height: 100)
        .background(Color.white)
        .clipShape(.rect(cornerRadius: 10))
    }
}

#Preview {
    ProgressCard(progress: Progress(uuid: UUID(), name: "Name", description: "Description", unit: "Days", totalQuantity: 30, quantity: 5), decrement: {}, increment: {}, action: {})
        .padding()
        .background(Color.bgCon)
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    func cornerRadius(_ radius: CGFloat, firstOrLastElement isFirst: Bool?) -> some View {
        guard let isFirst = isFirst else { return cornerRadius(radius, corners: [.allCorners]) }
        if isFirst {
            return cornerRadius(radius, corners: [.topLeft, .topRight])
        } else {
            return cornerRadius(radius, corners: [.bottomLeft, .bottomRight])
        }
    }
}
