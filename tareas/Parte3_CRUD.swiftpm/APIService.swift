import Foundation

class APIService {
    // la api del profe, en simulador se conecta al localhost de la mac
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
                let libros = try JSONDecoder().decode([Book].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(libros))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
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
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                let ok = error == nil && (response as? HTTPURLResponse)?.statusCode == 200
                completion(ok)
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
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                let ok = error == nil && (response as? HTTPURLResponse)?.statusCode == 200
                completion(ok)
            }
        }.resume()
    }
    
    static func deleteBook(id: Int, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: baseURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["id": id])
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                let ok = error == nil && (response as? HTTPURLResponse)?.statusCode == 200
                completion(ok)
            }
        }.resume()
    }
}
