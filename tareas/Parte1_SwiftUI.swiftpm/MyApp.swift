import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "screenshotMode") {
                let step = UserDefaults.standard.integer(forKey: "screenshotStep")
                switch step {
                case 1: Ejercicio1View()
                case 2: Ejercicio2View()
                case 3: Ejercicio3View()
                case 4: Ejercicio4View()
                default: ContentView()
                }
            } else {
                ContentView()
            }
        }
    }
}
