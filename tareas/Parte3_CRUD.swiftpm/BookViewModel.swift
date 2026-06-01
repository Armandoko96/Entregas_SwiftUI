import Foundation
import CoreData
import SwiftUI

class BookViewModel: ObservableObject {
    @Published var books: [Book] = []
    private var context = CoreDataManager.shared.container.viewContext
    
    init() {
        fetchLocalBooks()
        syncWithAPI()
    }
    
    func fetchLocalBooks() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest() as! NSFetchRequest<BookEntity>
        do {
            let entities = try context.fetch(request)
            self.books = entities.map { entity in
                Book(id: Int(entity.id), title: entity.title ?? "", author: entity.author ?? "", release_year: Int(entity.release_year))
            }
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func syncWithAPI() {
        APIService.fetchBooks { [weak self] result in
            switch result {
            case .success(let remoteBooks):
                self?.books = remoteBooks
                self?.updateLocalDB(with: remoteBooks)
            case .failure(let error):
                print("API Sync error: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateLocalDB(with remoteBooks: [Book]) {
        // Clear local and insert new (simple sync strategy)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BookEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        _ = try? context.execute(deleteRequest)
        
        for book in remoteBooks {
            let entity = BookEntity(context: context)
            entity.id = Int32(book.id)
            entity.title = book.title
            entity.author = book.author
            entity.release_year = Int32(book.release_year)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func addBook(title: String, author: String, year: Int) {
        // Optimistic ID creation
        let newId = (books.map { $0.id }.max() ?? 0) + 1
        let newBook = Book(id: newId, title: title, author: author, release_year: year)
        
        books.append(newBook)
        
        APIService.createBook(newBook) { success in
            if success {
                self.syncWithAPI()
            } else {
                print("Error adding via API")
            }
        }
    }
    
    func updateBook(book: Book) {
        if let index = books.firstIndex(where: { $0.id == book.id }) {
            books[index] = book
        }
        
        APIService.updateBook(book) { success in
            if success {
                self.syncWithAPI()
            }
        }
    }
    
    func deleteBook(at offsets: IndexSet) {
        offsets.forEach { index in
            let book = books[index]
            books.remove(at: index)
            APIService.deleteBook(id: book.id) { success in
                if success {
                    self.syncWithAPI()
                }
            }
        }
    }
}
