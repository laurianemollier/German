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
    
    func find(verbId: Int64) throws -> LearningVerb? {
        let q = LearningVerbTable
            .learningVerbs
            .where(LearningVerbTable.verbId == verbId)
        return try db.pluck(q)?.toUserLearningVerb()
    }
    
    func verbToReviewTodayCount() throws -> Int{
        let today = Date()
        return try verbToReviewCount(on: today)
    }
    
    func verbToReviewCount(on: Date) throws -> Int{
        let verbs = LearningVerbTable
            .learningVerbs
            .filter(LearningVerbTable.dateToReview <= on)
        return try db.scalar(verbs.count)
    }

    func nbrVerbInReviewList() throws -> Int {
        let verbs = LearningVerbTable
            .learningVerbs
            .filter(LearningVerbTable.userProgression != UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    /// The number of verb in the review list
    func nbrVerNotbInReviewList() throws -> Int {
        let verbs = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    
    func addRandomVerbToReviewList(ofLevel: [Level], nbr: Int) throws {
        
        // TODO to make it more effective in one query, because now it is horrible!
        let q = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        
        
        let learningVerbs: [LearningVerb] = try db.prepare(q).map{ row in
            try row.toUserLearningVerb()
        }.filter({ofLevel.contains($0.verb.level)})
        
        let selected = learningVerbs.choose(nbr)
        for verb in selected{
            let updated = verb.set(userProgression: UserProgression.level1, dateToReview: Date())
            _ = try update(learningVerb: updated.toDbUserLearningVerb())
        }
    }
    
    
    /// The verb that the user has to review today
    func verbsToReviewToday(limit: Int?) throws -> [LearningVerb]{
        let today = Date()
        return try verbsToReview(on: today, limit: limit)
    }
    
    /// The verb that the user has to review on the date "on"
    func verbsToReview(on: Date, limit: Int?) throws -> [LearningVerb]{
        let q = LearningVerbTable.learningVerbs
            .filter(LearningVerbTable.dateToReview <= on)
            .limit(limit)
        
        return try db.prepare(q).map{ row in
            try row.toUserLearningVerb()
        }
    }
    
    
    /// - Retruns: If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerb: DbLearningVerb) throws -> Int{
        let table: Table = LearningVerbTable.learningVerbs.where(LearningVerbTable.id == learningVerb.id)
        let update: Update = table.update(LearningVerbTable.verbId <- learningVerb.id,
                                          LearningVerbTable.dateToReview <- learningVerb.dateToReview,
                                          LearningVerbTable.userProgression <- learningVerb.userProgression)
        return try db.run(update)
    }
    
    
    func update(learningVerbs: [DbLearningVerb]) throws -> [Int]{
        return try learningVerbs.map({ v in try update(learningVerb: v)})
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
        
        let verb = try DAO.verbDAO.find(id:  self[LearningVerbTable.verbId])!
        
        return LearningVerb(id: id, verb: verb, dateToReview: dateToReview, userProgression: userProgression)
    }
}
