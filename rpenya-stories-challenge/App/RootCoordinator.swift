//
//  RootCoordinator.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 27/2/26.
//

@MainActor
class RootCoordinator {
    func makeStoryListViewModel() throws -> StoryListViewModel {
        let storyRepository = try StoryDataRepository()
        let userActivityRepository = UserActivityDataRepository()
        return try StoryListViewModel(storyRepository: storyRepository,
                                           activityRepository: userActivityRepository)
    }
}
