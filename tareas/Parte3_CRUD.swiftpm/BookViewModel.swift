import Foundation
import CoreData
import SwiftUI

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var context = CoreDataManager.shared.container.viewContext
    
    init() {
        cargarLibrosLocales()
        syncWithAPI()
    }
    
    func cargarLibrosLocales() {
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        do {
            let entities = try context.fetch(request)
            self.books = entities.map { e in
                Book(id: Int(e.id), title: e.title ?? "", author: e.author ?? "", release_year: Int(e.release_year))
            }
        } catch {
            print("Error al leer Core Data: \(error)")
        }
    }
    
    func syncWithAPI() {
        APIService.fetchBooks { result in
            switch result {
            case .success(let librosRemoto):
                self.books = librosRemoto
                self.guardarEnLocal(librosRemoto)
            case .failure(let error):
                print("No se pudo conectar con la API: \(error.localizedDescription)")
            }
        }
    }
    
    private func guardarEnLocal(_ libros: [Book]) {
        // borramos y volvemos a insertar para tener todo sincronizado
        let deleteReq = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
        let batch = NSBatchDeleteRequest(fetchRequest: deleteReq)
        _ = try? context.execute(batch)
        
        for libro in libros {
            let entity = BookEntity(context: context)
            entity.id = Int32(libro.id)
            entity.title = libro.title
            entity.author = libro.author
            entity.release_year = Int32(libro.release_year)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func addBook(title: String, author: String, year: Int) {
        let nuevoId = (books.map { $0.id }.max() ?? 0) + 1
        let nuevo = Book(id: nuevoId, title: title, author: author, release_year: year)
        books.append(nuevo)
        
        // Persistencia inmediata local en Core Data
        let entity = BookEntity(context: context)
        entity.id = Int32(nuevo.id)
        entity.title = nuevo.title
        entity.author = nuevo.author
        entity.release_year = Int32(nuevo.release_year)
        CoreDataManager.shared.saveContext()
        
        APIService.createBook(nuevo) { ok in
            if ok { self.syncWithAPI() }
        }
    }
    
    func updateBook(book: Book) {
        if let i = books.firstIndex(where: { $0.id == book.id }) {
            books[i] = book
        }
        
        // Persistencia inmediata local en Core Data
        let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
        request.predicate = NSPredicate(format: "id == %d", book.id)
        if let results = try? context.fetch(request), let entity = results.first {
            entity.title = book.title
            entity.author = book.author
            entity.release_year = Int32(book.release_year)
            CoreDataManager.shared.saveContext()
        }
        
        APIService.updateBook(book) { ok in
            if ok { self.syncWithAPI() }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        offsets.forEach { i in
            let libro = books[i]
            books.remove(at: i)
            
            // Persistencia inmediata local en Core Data
            let request = NSFetchRequest<BookEntity>(entityName: "BookEntity")
            request.predicate = NSPredicate(format: "id == %d", libro.id)
            if let results = try? context.fetch(request), let entity = results.first {
                context.delete(entity)
                CoreDataManager.shared.saveContext()
            }
            
            APIService.deleteBook(id: libro.id) { ok in
                if ok { self.syncWithAPI() }
            }
        }
    }
}
