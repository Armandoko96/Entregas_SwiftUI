import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Ejercicio1View()
                .tag(0)
                .tabItem {
                    Label("Ej 1", systemImage: "person.crop.circle")
                }
            
            Ejercicio2View()
                .tag(1)
                .tabItem {
                    Label("Ej 2", systemImage: "square.grid.2x2")
                }
                
            Ejercicio3View()
                .tag(2)
                .tabItem {
                    Label("Ej 3", systemImage: "photo.on.rectangle")
                }
                
            Ejercicio4View()
                .tag(3)
                .tabItem {
                    Label("Ej 4", systemImage: "hand.tap")
                }
        }
        .onReceive(timer) { _ in
            if UserDefaults.standard.bool(forKey: "screenshotMode") {
                withAnimation {
                    selectedTab = (selectedTab + 1) % 4
                }
            }
        }
    }
}
