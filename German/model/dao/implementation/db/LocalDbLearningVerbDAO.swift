//
//  LocalDbLearningVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

final class LocalDbLearningVerbDAO: DbLearningVerbDAO {
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    func createTable() throws {
        SpeedLog.print("Create VerbTranslationTable...")
        try self.db.run(LearningVerbTable.createTable)
        SpeedLog.print("VerbTranslationTable created")
    }
    
    
    func insert(learningVerb: DbLearningVerb) throws -> DbLearningVerb{
        SpeedLog.print("Insert DbUserLearningVerb ...")
        let insert = LearningVerbTable.learningVerbs.insert(
            LearningVerbTable.verbId <- learningVerb.verbId,
            LearningVerbTable.dateToReview <- learningVerb.dateToReview,
            LearningVerbTable.userProgression <- learningVerb.userProgression)
        
        let id: Int64 = try db.run(insert)
        SpeedLog.print("DbUserLearningVerb inserted ")
        return DbLearningVerb(id: id,
                              verbId: learningVerb.verbId,
                              dateToReview: learningVerb.dateToReview,
                              userProgression: learningVerb.userProgression)
    }
    
    
    func insert(learningVerbs: [DbLearningVerb]) throws -> [DbLearningVerb]{
        return try learningVerbs.map({ v in try insert(learningVerb: v)})
    }
    
}
