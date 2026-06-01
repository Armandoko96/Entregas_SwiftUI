import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var showError = false
    
    func login() -> Bool {
        if username == "admin" && password == "1234" {
            UserDefaults.standard.set(username, forKey: "loggedInUser")
            return true
        } else {
            showError = true
            return false
        }
    }
}

struct LoginView: View {
    @StateObject private var vm = LoginViewModel()
    @State private var isLoggedIn = UserDefaults.standard.string(forKey: "loggedInUser") != nil
    
    var body: some View {
        if isLoggedIn {
            MenuView(isLoggedIn: $isLoggedIn)
        } else {
            VStack(spacing: 20) {
                Text("Bienvenido")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image(systemName: "book.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                TextField("Usuario", text: $vm.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                
                SecureField("Contraseña", text: $vm.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if vm.showError {
                    Text("Credenciales incorrectas")
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    if vm.login() {
                        isLoggedIn = true
                    }
                }) {
                    Text("Ingresar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
    }
}
