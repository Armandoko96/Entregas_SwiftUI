import SwiftUI

struct CardView: View {
    let imageName: String
    let title: String
    let author: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Por: \(author)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(description)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)
        }
        .padding()
        .frame(width: 300)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

struct Ejercicio3View: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Galería de Tarjetas")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
                .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    CardView(imageName: "photo.artframe", title: "Paisaje Montañoso", author: "Luis Armando", description: "Una hermosa vista de las montañas nevadas al amanecer.")
                    CardView(imageName: "camera.macro", title: "Naturaleza", author: "Luis Armando", description: "Fotografía macro de una hoja con gotas de rocío matutino.")
                    CardView(imageName: "building.columns", title: "Arquitectura", author: "Luis Armando", description: "Edificios históricos en el centro de la ciudad de Europa.")
                    CardView(imageName: "airplane.departure", title: "Viajes", author: "Luis Armando", description: "Avión despegando hacia un nuevo destino emocionante.")
                }
                .padding()
            }
            Spacer()
        }
    }
}
