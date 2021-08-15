//
//  LearningVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

protocol LearningVerbDAO {
    
    // -------------
    // Mark: - write
    // -------------
    
    /// - Retruns: If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerb: DbLearningVerb) throws -> Int
    
    func update(learningVerbs: [DbLearningVerb]) throws -> [Int]
    
    func addRandomVerbToReviewList(ofLevel: [Level], count: Int) throws
    
    // -------------
    // Mark: - read
    // -------------
    
    func find(verbId: Int64) throws -> LearningVerb?
    
    func all() throws -> [LearningVerb]
    
    func select(userProgression: UserProgression) throws -> [LearningVerb]
    
    // Mark: - verb to review
    
    /// The verbs that the user has to review today
    func verbToReviewToday(limit: Int?) throws -> [LearningVerb]
    
    /// The number of verb that the user has to review today
    func verbToReviewTodayCount() throws -> Int
    
    /// The verbs that the user has to review on the date "on"
    func verbToReview(on: Date, limit: Int?) throws -> [LearningVerb]
    
    /// The number of verb that the user has to review on the date "on"
    func verbToReviewCount(on: Date) throws -> Int
    
    /// The number of verb in the review list
    func verbInReviewListCount() throws -> Int
    
    /// The number of verb in the review list
    func verNotInReviewListCount() throws -> Int
    
}
