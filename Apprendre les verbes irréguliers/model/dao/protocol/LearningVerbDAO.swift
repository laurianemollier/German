//
//  LearningVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

protocol LearningVerbDAO {
    
    func find(verbId: Int64) throws -> LearningVerb?
    
    /// The number of verb that the user has to review today
    func verbToReviewTodayCount() throws -> Int
    
    /// The number of verb that the user has to review on the date "on"
    func verbToReviewCount(on: Date) throws -> Int
    
    /// The number of verb in the review list
    func nbrVerbInReviewList() throws -> Int
    
    /// The number of verb in the review list
    func nbrVerNotbInReviewList() throws -> Int
    
    func addRandomVerbToReviewList(ofLevel: [Level], nbr: Int) throws
    
    /// The verb that the user has to review today
    func verbsToReviewToday(limit: Int?) throws -> [LearningVerb]
    
    /// The verb that the user has to review on the date "on"
    func verbsToReview(on: Date, limit: Int?) throws -> [LearningVerb]
    
    /// - Retruns: If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerb: DbLearningVerb) throws -> Int
    
    func update(learningVerbs: [DbLearningVerb]) throws -> [Int]
    
    func all() throws -> [LearningVerb]
    
    func select(userProgression: UserProgression) throws -> [LearningVerb]
}
