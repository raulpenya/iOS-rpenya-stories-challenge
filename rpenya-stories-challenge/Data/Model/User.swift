//
//  User.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let profilePictureURL: URL
}
