//
//  Untitled.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct UserActivity: Codable {
    let userId: Int
    var seenStoryIds: Set<Int>
    var likedStoryIds: Set<Int>
}
