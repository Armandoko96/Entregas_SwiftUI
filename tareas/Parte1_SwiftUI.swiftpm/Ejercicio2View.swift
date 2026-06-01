import SwiftUI

// Subview para los recuadros pequeños
struct ProductItemView: View {
    let imageName: String
    let title: String
    let price: String
    let bgColor: Color
    let textColor: Color
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding()
                .background(Color.white.opacity(0.8))
                .clipShape(Circle())
            
            Text(title)
                .font(.headline)
                .foregroundColor(textColor)
                
            Text(price)
                .font(.subheadline)
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(bgColor)
        .cornerRadius(15)
    }
}

struct Ejercicio2View: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Titulo resaltado
                Text("Nuestros Productos")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // Primer Renglon (2 vistas)
                HStack(spacing: 15) {
                    ProductItemView(imageName: "laptopcomputer", title: "Laptop", price: "$999", bgColor: .indigo, textColor: .white)
                    ProductItemView(imageName: "candybarphone", title: "Smartphone", price: "$699", bgColor: .teal, textColor: .white)
                }
                .padding(.horizontal)
                
                // Segundo Renglon (Doble, sin imagen, texto promocional en ZStack)
                ZStack {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(height: 120)
                    
                    VStack {
                        Text("¡GRAN PROMOCIÓN!")
                            .font(.title2)
                            .fontWeight(.black)
                            .foregroundColor(.white)
                        Text("50% de descuento en todos los accesorios")
                            .font(.body)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                // Tercer Renglon (2 vistas)
                HStack(spacing: 15) {
                    ProductItemView(imageName: "headphones", title: "Audífonos", price: "$199", bgColor: .mint, textColor: .black)
                    ProductItemView(imageName: "applewatch", title: "Smartwatch", price: "$299", bgColor: .pink, textColor: .white)
                }
                .padding(.horizontal)
                
            }
            .padding(.vertical)
        }
    }
}
