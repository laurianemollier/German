//
//  DbVerbTranslationDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

final class LocalLearningVerbDAO: LearningVerbDAO{
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    // -------------
    // Mark: - write
    // -------------
    
    
    func update(learningVerb: DbLearningVerb) throws -> Bool {
        let table: Table = LearningVerbTable.learningVerbs.where(LearningVerbTable.id == learningVerb.id)
        let update: Update = table.update(LearningVerbTable.verbId <- learningVerb.id,
                                          LearningVerbTable.dateToReview <- learningVerb.dateToReview,
                                          LearningVerbTable.userProgression <- learningVerb.userProgression)
        return try db.run(update) > 0
    }
    
    
    func update(learningVerbs: [DbLearningVerb]) throws -> Bool{
        return try learningVerbs.map{ v in
            try update(learningVerb: v)
        }.forAll(where: {b in b})
    }
    
    func addRandomVerbToReviewList(ofLevel: [Level], count: Int) throws {
        
        // TODO to make it more effective in one query
        let q = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        
        
        let learningVerbs: [LearningVerb] = try db.prepare(q).map{ row in
            try row.toUserLearningVerb()
        }.filter({ofLevel.contains($0.verb.level)})
        
        let selected = learningVerbs.choose(count)
        for verb in selected{
            let updated = verb.set(userProgression: UserProgression.level1, dateToReview: Date())
            _ = try update(learningVerb: updated.toDbUserLearningVerb())
        }
    }
    
    // -------------
    // Mark: - read
    // -------------
    
    func find(verbId: Int64) throws -> LearningVerb? {
        let q = LearningVerbTable
            .learningVerbs
            .where(LearningVerbTable.verbId == verbId)
        return try db.pluck(q)?.toUserLearningVerb()
    }
    
    func all() throws -> [LearningVerb]{
        let rows = try db.prepare(LearningVerbTable.learningVerbs)
        return try rows.map({ row in
            try row.toUserLearningVerb()
        })
    }
    
    func select(userProgression: UserProgression) throws -> [LearningVerb] {
        let rows = try db.prepare(LearningVerbTable.learningVerbs
                                    .filter(LearningVerbTable.userProgression == userProgression.rawValue))
        return try rows.map({ row in
            try row.toUserLearningVerb()
        })
    }
    
    // Mark: - verb to review
    
    func verbToReviewToday(limit: Int?) throws -> [LearningVerb]{
        let today = Date()
        return try verbToReview(on: today, limit: limit)
    }
    
    func verbToReviewTodayCount() throws -> Int{
        let today = Date()
        return try verbToReviewCount(on: today)
    }
    
    func verbToReview(on: Date, limit: Int?) throws -> [LearningVerb]{
        let q = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.dateToReview <= on)
            .limit(limit)
        
        return try db.prepare(q).map{ row in
            try row.toUserLearningVerb()
        }
    }
    
    func verbToReviewCount(on: Date) throws -> Int{
        let verbs = LearningVerbTable
            .learningVerbs
            .filter(LearningVerbTable.dateToReview <= on)
        return try db.scalar(verbs.count)
    }
    
    func verbInReviewListCount() throws -> Int {
        let verbs = LearningVerbTable
            .learningVerbs
            .filter(LearningVerbTable.userProgression != UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    func verNotInReviewListCount() throws -> Int {
        let verbs = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
}

private extension Row {
    
    /// Transforms a UserLearningVerbTable's row to UserLearningVerb.
    /// We assume that the datebase is constistant, and that for each UserLearningVerbTable's row exist
    /// an unit Verb.
    /// - Parameters:
    ///     - row: A UserLearningVerbTable's row
    /// - Returns: The UserLearningVerb that is associated with this row
    func toUserLearningVerb() throws -> LearningVerb {
        let id = self[LearningVerbTable.id]
        let dateToReview = self[LearningVerbTable.dateToReview]
        let userProgression = UserProgression(rawValue: self[LearningVerbTable.userProgression])!
        
        let verb = try DAO.verbDAO.find(id: self[LearningVerbTable.verbId])
        
        return LearningVerb(id: id, verb: verb, dateToReview: dateToReview, userProgression: userProgression)
    }
}
