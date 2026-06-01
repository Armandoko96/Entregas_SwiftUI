import SwiftUI

struct BookListView: View {
    @StateObject private var vm = BookViewModel()
    
    var body: some View {
        List {
            ForEach(vm.books) { book in
                NavigationLink(destination: BookFormView(vm: vm, editingBook: book)) {
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text("Año: \(book.release_year)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .onDelete(perform: vm.deleteBook)
        }
        .navigationTitle("Catálogo de Libros")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: BookFormView(vm: vm, editingBook: nil)) {
                    Image(systemName: "plus")
                }
            }
        }
        .onAppear {
            vm.syncWithAPI()
        }
    }
}
