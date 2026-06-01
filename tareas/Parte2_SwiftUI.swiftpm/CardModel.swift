import Foundation

struct CardModel: Identifiable {
    let id = UUID()
    let imageName: String?
    let title: String
    let subtitle: String
}

// Sample Data
let sampleCards: [CardModel] = [
    CardModel(imageName: "photo.artframe", title: "Montaña", subtitle: "Paisaje natural"),
    CardModel(imageName: nil, title: "Nota sin foto", subtitle: "Solo texto"),
    CardModel(imageName: "camera.macro", title: "Bosque", subtitle: "Naturaleza profunda"),
    CardModel(imageName: "building.columns", title: "Museo", subtitle: "Historia antigua"),
    CardModel(imageName: nil, title: "Recordatorio", subtitle: "Comprar víveres")
]
