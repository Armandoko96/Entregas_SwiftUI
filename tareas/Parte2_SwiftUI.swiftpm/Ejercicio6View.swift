import SwiftUI

struct Ejercicio6View: View {
    @EnvironmentObject var settings: SettingsStore
    
    var filteredAndSortedCards: [CardModel] {
        var result = sampleCards
        
        // Filtro de foto
        if settings.showOnlyWithPhoto {
            result = result.filter { $0.imageName != nil }
        }
        
        // Ordenamiento
        if settings.orderType == 0 {
            result.sort { $0.title < $1.title }
        } else {
            result.sort { $0.title > $1.title }
        }
        
        // Limite
        return Array(result.prefix(settings.itemLimit))
    }
    
    var body: some View {
        NavigationView {
            List(filteredAndSortedCards) { card in
                NavigationLink(destination: DetalleCardView(card: card)) {
                    HStack {
                        if let imageName = card.imageName {
                            Image(systemName: imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } else {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: 50, height: 50)
                                .overlay(Text("S/F").font(.caption))
                                .cornerRadius(8)
                        }
                        
                        VStack(alignment: .leading) {
                            Text(card.title)
                                .font(.headline)
                            Text(card.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Lista de Cartas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ConfiguracionView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }
    }
}
