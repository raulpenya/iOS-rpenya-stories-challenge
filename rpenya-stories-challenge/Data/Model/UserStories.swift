//
//  UserStories.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct UserStories: Identifiable, Decodable {
    let id: Int
    let user: User
    let stories: [Story]
}
