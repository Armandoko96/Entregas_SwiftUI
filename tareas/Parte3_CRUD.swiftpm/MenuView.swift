import SwiftUI

struct MenuView: View {
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                NavigationLink(destination: BookListView()) {
                    Label("Ir al Catálogo de Libros", systemImage: "books.vertical.fill")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationTitle("Menú Principal")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cerrar Sesión") {
                        UserDefaults.standard.removeObject(forKey: "loggedInUser")
                        isLoggedIn = false
                    }
                }
            }
        }
    }
}
