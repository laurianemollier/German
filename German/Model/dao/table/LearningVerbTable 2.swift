//
//  UserLearningVerbTable.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


class LearningVerbTable{
    
    static let learningVerbs = Table("userLearningVerbs")
    
    /// The id for the verb
    static let id = Expression<Int64>("id")
    
    static let verbId = Expression<Int64>("verbId")
    
    static let dateToReview = Expression<Date?>("dateToReview")
    
    static let userProgression = Expression<String>("userProgression")
    
    static let createTable = LearningVerbTable.learningVerbs.create { (t) in
        t.column(LearningVerbTable.id, primaryKey: .autoincrement)
        t.column(LearningVerbTable.verbId)
        t.column(LearningVerbTable.dateToReview)
        t.column(LearningVerbTable.userProgression)
        t.foreignKey(LearningVerbTable.verbId, references: VerbTable.verbs, VerbTable.id, delete: .cascade)
    }
}
