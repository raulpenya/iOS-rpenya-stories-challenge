import CoreData

final class CoreDataUserRepository: UserRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchUsers() async throws -> [UserData] {
        []
    }

    func save(_ user: UserData) async throws {
        try context.saveIfNeeded()
    }
}
