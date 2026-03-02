//
//  StoryListViewmodel.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct AlertError: Identifiable {
    let id = UUID()
    let message: String
}

@Observable
final class StoryListViewModel {

    private(set) var userActivity: UserActivity
    private(set) var stories: [Story] = []
    var alertError: AlertError?

    private let storyRepository: StoryRepository
    private let activityRepository: UserActivityRepository
    private var currentPageIndex = 0
    private var isLoading = false

    init(storyRepository: StoryRepository,
         activityRepository: UserActivityRepository) throws {

        self.storyRepository = storyRepository
        self.activityRepository = activityRepository

        self.userActivity =
            try activityRepository.getUserActivity() ??
            UserActivity(seenStoryIds: [], likedStoryIds: [])
    }
    
    func loadNextPage() {
        guard !isLoading else { return }
        isLoading = true
        
        do {
            let newStories = try storyRepository.getStories(with: currentPageIndex)
            stories.append(contentsOf: newStories)
            currentPageIndex += 1
        } catch {
            alertError = AlertError(message: error.localizedDescription)
        }
        
        isLoading = false
    }
    
    func isLast(_ index: Int) -> Bool {
        return index == stories.count - 1
    }
    
    func isSeen(_ story: Story) -> Bool {
        userActivity.seenStoryIds.contains(story.id)
    }

    func isLiked(_ story: Story) -> Bool {
        userActivity.likedStoryIds.contains(story.id)
    }
    
    func toggleLike(for story: Story) {
        if userActivity.likedStoryIds.contains(story.id) {
            userActivity.likedStoryIds.remove(story.id)
        } else {
            userActivity.likedStoryIds.insert(story.id)
        }
        do {
            try activityRepository.updateUserActivity(userActivity)
        } catch {
            alertError = AlertError(message: error.localizedDescription)
        }
    }
    
    func markAsSeen(_ story: Story) {
        userActivity.seenStoryIds.insert(story.id)
        do {
            try activityRepository.updateUserActivity(userActivity)
        } catch {
            alertError = AlertError(message: error.localizedDescription)
        }
    }
}
