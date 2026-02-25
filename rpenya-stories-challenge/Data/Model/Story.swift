//
//  Story.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

struct Story: Identifiable, Decodable {
    let id: Int
    let userId: Int
    let pictureURL: URL
}
