import SwiftUI

struct BookFormView: View {
    @ObservedObject var vm: BookViewModel
    var editingBook: Book?
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var year: String = ""
    
    var body: some View {
        Form {
            Section(header: Text("Detalles del Libro")) {
                TextField("Título", text: $title)
                TextField("Autor", text: $author)
                TextField("Año de Lanzamiento", text: $year)
                    .keyboardType(.numberPad)
            }
            
            Button(action: {
                save()
            }) {
                Text(editingBook == nil ? "Agregar Libro" : "Guardar Cambios")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.blue)
            }
        }
        .navigationTitle(editingBook == nil ? "Nuevo Libro" : "Editar Libro")
        .onAppear {
            if let book = editingBook {
                title = book.title
                author = book.author
                year = "\(book.release_year)"
            }
        }
    }
    
    private func save() {
        guard let yearInt = Int(year) else { return }
        
        if let book = editingBook {
            let updatedBook = Book(id: book.id, title: title, author: author, release_year: yearInt)
            vm.updateBook(book: updatedBook)
        } else {
            vm.addBook(title: title, author: author, year: yearInt)
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
