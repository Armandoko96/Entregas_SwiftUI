import Foundation

struct Book: Identifiable, Codable {
    var id: Int
    var title: String
    var author: String
    var release_year: Int
}
