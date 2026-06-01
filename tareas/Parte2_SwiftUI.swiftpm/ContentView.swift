import SwiftUI

struct ContentView: View {
    @StateObject private var settings = SettingsStore()
    @State private var selectedTab = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Ejercicio5View()
                .tag(0)
                .tabItem {
                    Label("Ej 5: Estados", systemImage: "playpause.fill")
                }
            
            Ejercicio6View()
                .environmentObject(settings)
                .tag(1)
                .tabItem {
                    Label("Ej 6: Listas", systemImage: "list.bullet.rectangle")
                }
        }
        .onReceive(timer) { _ in
            if UserDefaults.standard.bool(forKey: "screenshotMode") {
                withAnimation {
                    selectedTab = (selectedTab + 1) % 2
                }
            }
        }
    }
}
