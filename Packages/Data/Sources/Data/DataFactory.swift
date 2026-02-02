import CoreData

public struct DataLayerFactory {

    public static func makeUserRepository(
        modelName: String
    ) -> UserRepository {

        let stack = CoreDataStack(modelName: modelName)
        return CoreDataUserRepository(
            context: stack.container.viewContext
        )
    }
}
