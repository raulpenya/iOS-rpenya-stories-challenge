//
//  Story.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct Story: Identifiable {
    let id: Int
    let pictureURL: URL
    let user: User
    
    init(user: User) {
        self.id = user.id
        self.pictureURL = user.profilePictureURL
        self.user = user
    }
}
