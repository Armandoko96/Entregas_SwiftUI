import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    init() {
        // Creación programática del modelo para evitar problemas con .xcdatamodeld en Swift Playgrounds
        let model = NSManagedObjectModel()
        
        let entity = NSEntityDescription()
        entity.name = "BookEntity"
        entity.managedObjectClassName = NSStringFromClass(BookEntity.self)
        
        let idAttr = NSAttributeDescription()
        idAttr.name = "id"
        idAttr.attributeType = .integer32AttributeType
        idAttr.isOptional = false
        
        let titleAttr = NSAttributeDescription()
        titleAttr.name = "title"
        titleAttr.attributeType = .stringAttributeType
        titleAttr.isOptional = true
        
        let authorAttr = NSAttributeDescription()
        authorAttr.name = "author"
        authorAttr.attributeType = .stringAttributeType
        authorAttr.isOptional = true
        
        let yearAttr = NSAttributeDescription()
        yearAttr.name = "release_year"
        yearAttr.attributeType = .integer32AttributeType
        yearAttr.isOptional = false
        
        entity.properties = [idAttr, titleAttr, authorAttr, yearAttr]
        model.entities = [entity]
        
        container = NSPersistentContainer(name: "CRUDModel", managedObjectModel: model)
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error.localizedDescription)")
            }
        }
    }
}
