//
//  PersistenceService.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct PersistenceService {
    let userDefaults: UserDefaults
    
    static let userActivityKey = "userActivity"
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func loadUserActitvity() throws -> UserActivity? {
        guard let savedData = userDefaults.data(forKey: Self.userActivityKey) else { return nil }
        return try JSONDecoder().decode(UserActivity.self, from: savedData)
    }
    
    func save(_ userActivity: UserActivity) throws {
        let data = try JSONEncoder().encode(userActivity)
        userDefaults.set(data, forKey: Self.userActivityKey)
    }
}
