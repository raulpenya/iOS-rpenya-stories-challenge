//
//  StoryRepository.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

protocol StoryRepository {
    func getStories(with page: Int) throws -> [Story]
}

struct StoryDataRepository: StoryRepository {
    private let pages: [Page]
    
    init() throws {
        self.pages = try StoryDataRepository.parsePages()
    }

    func getStories(with page: Int) throws -> [Story] {
        guard !pages.isEmpty else { return [] }
        let index = page % pages.count
        return pages[index].users.map { Story(user: $0) }
    }
    
    private func generateStories(with users: [User]) -> [Story] {
        return users.compactMap { user in
            Story(user: user)
        }
    }
    
    private static func parsePages() throws -> [Page] {
        guard let path = Bundle.main.path(forResource: "users", ofType: "json") else {
            throw NSError(domain: "Error", code: 0, userInfo: nil)
        }
        let fileUrl = URL(fileURLWithPath: path)
        let data = try Data(contentsOf: fileUrl)
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.pages
    }
}
