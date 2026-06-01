import SwiftUI

// Vista reutilizable para los botones contadores
struct CounterButtonView: View {
    let color: Color
    @Binding var count: Int
    
    var body: some View {
        Button(action: {
            count += 1
        }) {
            Text("Clics: \(count)")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 100, height: 100)
                .background(color)
                .clipShape(Circle())
                .shadow(radius: 3)
        }
    }
}

struct Ejercicio5View: View {
    @State private var isPlaying: Bool = false
    @State private var count1: Int = 0
    @State private var count2: Int = 0
    @State private var count3: Int = 0
    
    var totalCount: Int {
        count1 + count2 + count3
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Ejercicio 5: Estados")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // Botón Play/Stop
            Button(action: {
                isPlaying.toggle()
            }) {
                Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(isPlaying ? .red : .green)
                    .shadow(radius: 5)
            }
            
            // Botón central con la suma
            Text("Suma Total: \(totalCount)")
                .font(.title)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(15)
                .padding(.horizontal, 40)
            
            // Los 3 botones contadores
            HStack(spacing: 20) {
                CounterButtonView(color: .blue, count: $count1)
                CounterButtonView(color: .orange, count: $count2)
                CounterButtonView(color: .purple, count: $count3)
            }
            
            Spacer()
        }
        .padding(.top, 40)
    }
}
