//
//  Story.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct Story: Identifiable, Decodable {
    let id: Int
    let picture_url: String
    let user: User
    
    init(user: User) {
        self.id = user.id
        self.picture_url = user.profile_picture_url
        self.user = user
    }
}
