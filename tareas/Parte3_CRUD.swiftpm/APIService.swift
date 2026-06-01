import Foundation

class APIService {
    // Usamos localhost para emuladores iOS
    static let baseURL = "http://localhost/demoapi1/libros.php"
    
    static func fetchBooks(completion: @escaping (Result<[Book], Error>) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                DispatchQueue.main.async { completion(.success(books)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
    
    static func createBook(_ book: Book, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(book)
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil && (response as? HTTPURLResponse)?.statusCode == 200)
            }
        }.resume()
    }
    
    static func updateBook(_ book: Book, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(book)
        } catch {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil && (response as? HTTPURLResponse)?.statusCode == 200)
            }
        }.resume()
    }
    
    static func deleteBook(id: Int, completion: @escaping (Bool) -> Void) {
        // Enviar body JSON para el DELETE (según demoapi1 usual)
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["id": id]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(error == nil && (response as? HTTPURLResponse)?.statusCode == 200)
            }
        }.resume()
    }
}
