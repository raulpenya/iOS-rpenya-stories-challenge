//
//  UserActivityRepository.swift
//  rpenya-stories-challenge
//
//  Created by Raul Peña on 25/2/26.
//

import Foundation

protocol UserActivityRepository {
    func getUserActivity() throws -> UserActivity?
    func updateUserActivity(_ activity: UserActivity) throws
}

struct UserActivityDataRepository: UserActivityRepository {
    private let persistenceService: PersistenceService = PersistenceService()
    
    func getUserActivity() throws -> UserActivity? {
        try persistenceService.loadUserActitvity()
    }
    
    func updateUserActivity(_ activity: UserActivity) throws {
        try persistenceService.save(activity)
    }
}
