public protocol UserRepository {
    func fetchUsers() async throws -> [UserData]
    func save(_ user: UserData) async throws
}
