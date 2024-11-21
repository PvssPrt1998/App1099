import SwiftUI

struct Splash: View {
    
    @EnvironmentObject var source: Source
    @State var value: Double = 0
    @Binding var screen: Screen
    
    var body: some View {
        ZStack {
            Image("SplashBG")
                .resizable()
                .ignoresSafeArea()
                
            HStack(spacing: 8) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .frame(width: 30, height: 30)
                    .scaleEffect(1.5, anchor: .center)
                Text("\(Int(value * 100))%")
                    .font(.body.weight(.regular))
                    .foregroundColor(.white)
            }
            .padding(.top, UIScreen.main.bounds.height * 0.5)
                
            Image("SplashLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 319, height: 238)
                .padding(.top, -UIScreen.main.bounds.height * 0.25)
        }
        .onAppear {
            stroke()
            source.load()
        }
    }
    
    
    private func stroke() {
        if value < 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                self.value += 0.02
                self.stroke()
            }
        } else {
            if !source.loaded {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
                    self.stroke()
                }
            } else {
                screen = .main
            }
        }
    }
}

struct Splash_Preview: PreviewProvider {
    
    @State static var splash: Screen = .splash
    
    static var previews: some View {
        Splash(screen: $splash)
            .environmentObject(Source())
    }
}
