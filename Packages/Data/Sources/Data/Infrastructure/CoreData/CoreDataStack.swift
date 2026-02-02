import CoreData

final class CoreDataStack {

    let container: NSPersistentContainer

    init(modelName: String) {
        container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}
