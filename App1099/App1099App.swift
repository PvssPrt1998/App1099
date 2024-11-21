import SwiftUI

@main
struct App1099App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Source())
        }
    }
}
