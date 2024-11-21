import SwiftUI

struct SettingsView: View {
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        ZStack {
            Color.headerBg.ignoresSafeArea()
            Color.bgCon
            
            VStack(spacing: 0) {
                Text("Settings")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.headerText)
                    .padding(EdgeInsets(top: 3, leading: 16, bottom: 8, trailing: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.headerBg)
                
                VStack(spacing: 13) {
                    Button {
                        actionSheet()
                    } label: {
                        HStack(spacing: 4) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                            Text("Share app")
                                .font(.system(size: 17, weight: .regular))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 71)
                        .background(Color.headerBg)
                        .clipShape(.rect(cornerRadius: 12))
                    }
                    
                    HStack(spacing: 13) {
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/63d30c2a-fcb0-4a67-8e52-275cc4eb494a") {
                                openURL(url)
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "menucard")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                                Text("Terms of use")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 71)
                            .background(Color.headerBg)
                            .clipShape(.rect(cornerRadius: 12))
                        }
                        Button {
                            if let url = URL(string: "https://www.termsfeed.com/live/8a184234-8b0e-4817-9f43-2d5a566f1aa9") {
                                openURL(url)
                            }
                        } label: {
                            HStack(spacing: 4) {
                                Image(systemName: "shield")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                                Text("Privacy")
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 71)
                            .background(Color.headerBg)
                            .clipShape(.rect(cornerRadius: 12))
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 15)
                
                Image("SettingsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 128, height: 128)
                    .frame(maxHeight: .infinity)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            
            Rectangle()
                .fill(Color.black.opacity(0.3))
                .frame(height: 0.33)
                .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: "https://apps.apple.com/us/app/da-sorte-best-tracker/id6738490467")  else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        if #available(iOS 15.0, *) {
            UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController?
            .present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

#Preview {
    SettingsView()
}
