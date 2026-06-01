import SwiftUI

@main
struct MyApp: App {
    @StateObject private var settings = SettingsStore()
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "screenshotMode") {
                let step = UserDefaults.standard.integer(forKey: "screenshotStep")
                switch step {
                case 1: Ejercicio5View()
                case 2: Ejercicio6View()
                            .environmentObject(settings)
                case 3: ConfiguracionView()
                            .environmentObject(settings)
                default: ContentView()
                }
            } else {
                ContentView()
            }
        }
    }
}
