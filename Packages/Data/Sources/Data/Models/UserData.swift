import CoreData

public final class UserData: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var name: String
}
