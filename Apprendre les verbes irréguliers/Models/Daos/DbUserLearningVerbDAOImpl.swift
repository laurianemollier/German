//
//  DbVerbTranslationDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

class DbUserLearningVerbDAOImpl{
    
    let db: Connection
    
    private init(connection: Connection){
        self.db = connection
    }
    
    static let shared = DbUserLearningVerbDAOImpl(connection: Database.shared.connection!)
    
    func createTable() throws {
        SpeedLog.print("Create VerbTranslationTable...")
        try self.db.run(UserLearningVerbTable.createTable)
        SpeedLog.print("VerbTranslationTable created")
    }
    
    
    func insert(learningVerb: DbUserLearningVerb) throws -> DbUserLearningVerb{
        SpeedLog.print("Insert DbUserLearningVerb ...")
        let insert = UserLearningVerbTable.learningVerbs.insert(
            UserLearningVerbTable.verbId <- learningVerb.verbId,
            UserLearningVerbTable.dateToReview <- learningVerb.dateToReview,
            UserLearningVerbTable.userProgression <- learningVerb.userProgression)
        
        let id: Int64 = try db.run(insert)
        SpeedLog.print("DbUserLearningVerb inserted ")
        return DbUserLearningVerb(id: id,
                                  verbId: learningVerb.verbId,
                                  dateToReview: learningVerb.dateToReview,
                                  userProgression: learningVerb.userProgression)
    }
    
    
    func insert(learningVerbs: [DbUserLearningVerb]) throws -> [DbUserLearningVerb]{
        return try learningVerbs.map({ v in try insert(learningVerb: v)})
    }
    
    func find(verbId: Int64) throws -> UserLearningVerb? {
        
        let q = UserLearningVerbTable.learningVerbs.where(UserLearningVerbTable.verbId == verbId)
    
        if let row = try db.pluck(q) {
            return try toUserLearningVerb(userLVTableRow: row)
        } else {
            return nil
        }
    }
    
    
    
    /// The number of verb that the user has to review today
    func nbrVerbToReviewToday() throws -> Int{
        let today = Date()
        return try nbrVerbToReview(on: today)
    }
    
    /// The number of verb that the user has to review on the date "on"
    func nbrVerbToReview(on: Date) throws -> Int{
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.dateToReview <= on)
        return try db.scalar(verbs.count)
    }
    
    /// The number of verb in the review list
    func nbrVerbInReviewList() throws -> Int {
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.userProgression != UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    /// The number of verb in the review list
    func nbrVerNotbInReviewList() throws -> Int {
        let verbs = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        return try db.scalar(verbs.count)
    }
    
    
    func addRandomVerbToReviewList(ofLevel: [Level], nbr: Int) throws {

        // TODO to make it more effective in one query, because now it is horrible!
        let q = UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.userProgression == UserProgression.notSeenYet.rawValue)
        
        
        let learningVerbs: [UserLearningVerb] = try db.prepare(q).map{ row in
            try toUserLearningVerb(userLVTableRow: row)
        }.filter({ofLevel.contains($0.verb.level)})
        
        let selected = learningVerbs.choose(nbr)
        for verb in selected{
            let updated = verb.set(userProgression: UserProgression.level1, dateToReview: Date())
            _ = try update(learningVerb: updated.toDbUserLearningVerb())
        }
    }
    

    
    /// The verb that the user has to review today
    func verbsToReviewToday(limit: Int?) throws -> [UserLearningVerb]{
        let today = Date()
        return try verbsToReview(on: today, limit: limit)
    }
    
    /// The verb that the user has to review on the date "on"
    func verbsToReview(on: Date, limit: Int?) throws -> [UserLearningVerb]{
        let q_filter = UserLearningVerbTable.learningVerbs.filter(UserLearningVerbTable.dateToReview <= on)
        let q = toLimitedQuery(query: q_filter, limit: limit)
        
        return try db.prepare(q).map{ row in
            try toUserLearningVerb(userLVTableRow: row)
        }
    }
    
    
    /// - Retruns: If retrun value <= 0, the learningVer was not found
    ///            Else if the retrun value is > 0, the update was correctly done
    func update(learningVerb: DbUserLearningVerb) throws -> Int{
        let table: Table = UserLearningVerbTable.learningVerbs.where(UserLearningVerbTable.id == learningVerb.id)
        let update: Update = table.update(UserLearningVerbTable.verbId <- learningVerb.id,
                                    UserLearningVerbTable.dateToReview <- learningVerb.dateToReview,
                                    UserLearningVerbTable.userProgression <- learningVerb.userProgression)
        return try db.run(update)
    }
    
    
    func update(learningVerbs: [DbUserLearningVerb]) throws -> [Int]{
        return try learningVerbs.map({ v in try update(learningVerb: v)})
    }
    
    
    func all() throws -> [UserLearningVerb]{
        let rows = try db.prepare(UserLearningVerbTable.learningVerbs)
        return try rows.map({ row in
           try toUserLearningVerb(userLVTableRow: row)
        })
    }
    
    
    func select(userProgression: UserProgression) throws -> [UserLearningVerb] {
        let rows = try db.prepare(UserLearningVerbTable.learningVerbs
            .filter(UserLearningVerbTable.userProgression == userProgression.rawValue))
        return try rows.map({ row in
            try toUserLearningVerb(userLVTableRow: row)
        })
        
    }
    
    
    
    
    /* -Private functions: */
    

    /// Helper function to limit the query
    private func toLimitedQuery(query: Table, limit: Int?) -> Table{
        if let l = limit{
            return query.limit(l)
        }
        else {return query}
    }
    
    /// Transforms a UserLearningVerbTable's row to UserLearningVerb.
    /// We assume that the datebase is constistant, and that for each UserLearningVerbTable's row exist
    /// an unit Verb.
    /// - Parameters:
    ///     - row: A UserLearningVerbTable's row
    /// - Returns: The UserLearningVerb that is associated with this row
    private func toUserLearningVerb(userLVTableRow: Row) throws -> UserLearningVerb{
        let id = userLVTableRow[UserLearningVerbTable.id]
        let verb = try VerbDAOImpl.shared.find(id: userLVTableRow[UserLearningVerbTable.verbId])!
        let userProgression = UserProgression(rawValue: userLVTableRow[UserLearningVerbTable.userProgression])!
        let dateToReview = userLVTableRow[UserLearningVerbTable.dateToReview]
        
        return UserLearningVerb(id: id, verb: verb, dateToReview: dateToReview, userProgression: userProgression)
    }
    
    
    
    
    
    

    

    
    
    
    

    
}
