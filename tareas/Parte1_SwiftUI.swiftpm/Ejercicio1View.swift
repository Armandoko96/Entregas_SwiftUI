import SwiftUI

struct Ejercicio1View: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundColor(.blue)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                .shadow(radius: 5)
            
            Text("Luis Armando Ojeda Rodriguez")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 8) {
                Text("Ingeniería de Software")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text("Semestre 12")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.top, 50)
        .padding(.horizontal)
    }
}
