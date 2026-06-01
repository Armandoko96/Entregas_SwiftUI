import Foundation
import CoreData

@objc(BookEntity)
public class BookEntity: NSManagedObject {
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var release_year: Int32
}
