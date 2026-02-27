//
//  User.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct Root: Decodable {
    let pages: [Page]
}

struct Page: Decodable {
    let users: [User]
}

struct User: Identifiable, Decodable {
    let id: Int
    let name: String
    let profile_picture_url: String
}
