//
//  StoryRepository.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct StoryRepository {
    
    let persistenceService: PersistenceService = PersistenceService()

    func getStories() throws -> [Story] {
        let users: [User] = try parseUsers()
        let userActivity = try persistenceService.getUserActitvity()
        return generateStories(with: users, and: userActivity)
    }
    
    func addStoryAsSeen(story: Story) throws {
        try persistenceService.insertStoryAsSeen(story: story)
    }
    
    func addStoryAsLiked(story: Story) throws {
        try persistenceService.insertStoryAsLiked(story: story)
    }
    
    private func parseUsers() throws -> [User] {
        guard let path = Bundle.main.path(forResource: "questions", ofType: "json") else {
            throw NSError(domain: "Error", code: 0, userInfo: nil)
        }
        let fileUrl = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: fileUrl)
        return try JSONDecoder().decode([User].self, from: data)
    }
    
    private func generateStories(with users: [User], and activity: UserActivity?) -> [Story] {
        return users.compactMap { user in
            Story(user: user, activity: activity)
        }
    }
}
