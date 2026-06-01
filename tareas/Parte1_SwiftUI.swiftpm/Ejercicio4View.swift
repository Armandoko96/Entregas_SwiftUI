import SwiftUI

// Estilo de botón personalizado con Gradiente
struct GradientButtonStyle: ButtonStyle {
    let colors: [Color]
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct Ejercicio4View: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("Estilos de Botones")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Primer botón: Color sólido con borde usando paddings
            Button(action: {
                print("Botón 1 presionado")
            }) {
                Text("Botón 1")
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .padding(3) // Primer padding para el grosor del borde
                    .background(Color.blue) // Color del borde
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            
            // Segundo botón: Label con icono de borrar
            Button(action: {
                print("Botón Borrar presionado")
            }) {
                Label("Borrar", systemImage: "trash")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Tercer botón: Etiqueta con gradiente personalizado
            Button(action: {
                print("Botón Gradiente 1 presionado")
            }) {
                Label("Aceptar", systemImage: "checkmark.circle")
                    .font(.headline)
            }
            .buttonStyle(GradientButtonStyle(colors: [.green, .mint]))
            .padding(.horizontal)
            
            // Cuarto botón: Etiqueta con otro gradiente
            Button(action: {
                print("Botón Gradiente 2 presionado")
            }) {
                Label("Descubrir", systemImage: "sparkles")
                    .font(.headline)
            }
            .buttonStyle(GradientButtonStyle(colors: [.purple, .orange]))
            .padding(.horizontal)
            
            Spacer()
        }
        .padding(.top)
    }
}
