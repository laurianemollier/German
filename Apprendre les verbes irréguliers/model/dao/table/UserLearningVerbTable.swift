//
//  UserLearningVerbTable.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


class UserLearningVerbTable{
    
    static let learningVerbs = Table("userLearningVerbs")
    
    /// The id for the verb
    static let id = Expression<Int64>("id")
    
    static let verbId = Expression<Int64>("verbId")
    
    static let dateToReview = Expression<Date?>("dateToReview")
    
    static let userProgression = Expression<String>("userProgression")
    
    static let createTable = UserLearningVerbTable.learningVerbs.create { (t) in
        t.column(UserLearningVerbTable.id, primaryKey: .autoincrement)
        t.column(UserLearningVerbTable.verbId)
        t.column(UserLearningVerbTable.dateToReview)
        t.column(UserLearningVerbTable.userProgression)
        t.foreignKey(UserLearningVerbTable.verbId, references: VerbTable.verbs, VerbTable.id, delete: .cascade)
    }
}
