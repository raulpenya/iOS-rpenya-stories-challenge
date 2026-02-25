//
//  Story.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct Story: Identifiable, Decodable {
    let id: Int
    let pictureURL: URL
    let liked: Bool
    let seen: Bool
    let user: User
    
    init(user: User, activity: UserActivity?) {
        self.id = user.id
        self.pictureURL = user.profilePictureURL
        self.liked = activity?.likedStoryIds.contains(user.id) ?? false
        self.seen = activity?.seenStoryIds.contains(user.id) ?? false
        self.user = user
    }
}
