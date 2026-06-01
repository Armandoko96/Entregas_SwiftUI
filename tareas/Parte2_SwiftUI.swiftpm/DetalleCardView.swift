import SwiftUI

struct DetalleCardView: View {
    let card: CardModel
    
    var body: some View {
        VStack(spacing: 20) {
            if let imageName = card.imageName {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .foregroundColor(.blue)
                    .padding()
            } else {
                Image(systemName: "photo.badge.exclamationmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 250)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Text(card.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text(card.subtitle)
                .font(.title3)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle(card.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
