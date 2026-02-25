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
    
    func getUserActitvity() throws -> UserActivity? {
        guard let savedData = userDefaults.data(forKey: Self.userActivityKey) else { return nil }
        return try JSONDecoder().decode(UserActivity.self, from: savedData)
    }
    
    func insertStoryAsSeen(story: Story) throws {
        var userActivity = try getUserActitvity()
        if var userActivity {
            userActivity.seenStoryIds.insert(story.id)
        } else {
            userActivity = .init(seenStoryIds: [story.id], likedStoryIds: [])
        }
        let data = try JSONEncoder().encode(userActivity!)
        userDefaults.set(data, forKey: Self.userActivityKey)
    }
    
    func insertStoryAsLiked(story: Story) throws {
        var userActivity = try getUserActitvity()
        if var userActivity {
            userActivity.likedStoryIds.insert(story.id)
        } else {
            userActivity = .init(seenStoryIds: [], likedStoryIds: [story.id])
        }
        let data = try JSONEncoder().encode(userActivity!)
        userDefaults.set(data, forKey: Self.userActivityKey)
    }
}
