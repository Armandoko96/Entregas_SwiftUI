import SwiftUI

@main
struct MyApp: App {
    let persistenceController = CoreDataManager.shared
    @StateObject private var bookViewModel = BookViewModel()
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "screenshotMode") {
                let step = UserDefaults.standard.integer(forKey: "screenshotStep")
                switch step {
                case 1:
                    LoginView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                case 2:
                    MenuView(isLoggedIn: .constant(true))
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                case 3:
                    NavigationView {
                        BookListView()
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                case 4:
                    NavigationView {
                        BookFormView(vm: bookViewModel, editingBook: nil)
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                case 5:
                    NavigationView {
                        BookFormView(vm: bookViewModel, editingBook: Book(id: 1, title: "El Principito", author: "Antoine de Saint-Exupéry", release_year: 1943))
                    }
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
                default:
                    LoginView()
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                }
            } else {
                LoginView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
