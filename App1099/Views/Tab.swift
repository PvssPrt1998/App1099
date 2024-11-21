import SwiftUI

struct Tab: View {
    
    @State var selection = 0
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(rgbColorCodeRed: 42, green: 185, blue: 123, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 42, green: 185, blue: 123, alpha: 1)]

        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(rgbColorCodeRed: 0, green: 122, blue: 255, alpha: 1)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(rgbColorCodeRed: 0, green: 122, blue: 255, alpha: 1)]
        appearance.backgroundColor = UIColor.white
        appearance.shadowColor = .white.withAlphaComponent(0.15)
        appearance.shadowImage = UIImage(named: "tab-shadow")?.withRenderingMode(.alwaysTemplate)
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                SubscriptionView()
                    .tabItem { VStack {
                        tabViewImage("list.bullet.rectangle.portrait")
                        Text("Subscription") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(0)
                WorkoutView()
                    .tabItem { VStack {
                        Image(selection == 1 ? "figureStrengthSelected" : "figureStrength")
                        Text("Workout") .font(.system(size: 10, weight: .medium))
                    } }
                    .tag(1)
                AppProgressView()
                    .tabItem { VStack{
                        Image(selection == 2 ? "chartLineTextSelected" : "chartLine")
                        Text("Progress")
                            .font(.system(size: 10, weight: .medium))
                    }
                    }
                    .tag(2)
                AccountingView()
                    .tabItem {
                        VStack {
                            Image(selection == 3 ? "caseTabSelected" : "caseTab")
                            Text("Accounting") .font(.system(size: 10, weight: .medium))
                        }
                    }
                    .tag(3)
                SettingsView()
                    .tabItem {
                        VStack {
                            tabViewImage("gear")
                            Text("Settings") .font(.system(size: 10, weight: .medium))
                        }
                    }
                    .tag(4)
            }

        }
    }
    
    @ViewBuilder func tabViewImage(_ systemName: String) -> some View {
        if #available(iOS 15.0, *) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
                .environment(\.symbolVariants, .none)
        } else {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .medium))
        }
    }
}

#Preview {
    Tab()
        .environmentObject(Source())
}



extension UIColor {
   convenience init(rgbColorCodeRed red: Int, green: Int, blue: Int, alpha: CGFloat) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)
   }
}

extension UITabBarController {
    var height: CGFloat {
        return self.tabBar.frame.size.height
    }
    
    var width: CGFloat {
        return self.tabBar.frame.size.width
    }
}
