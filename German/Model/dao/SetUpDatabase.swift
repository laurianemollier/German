//
//  SetUpDatabase.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


class SetUpDatabase{
    
    static func setUp() throws {
        if Database.shared.successfulConnection {
            let dbLearningVerbDAO: DbLearningVerbDAO = LocalDbLearningVerbDAO(connection: Database.shared.connection!)
            try dbLearningVerbDAO.createTable()
            
            let dbUserLearningVerbs = Verbs.verbs.map{ v in
                DbLearningVerb(id: 0,
                               verbId: v.id,
                               dateToReview: nil,
                               userProgression: UserProgression.notSeenYet.rawValue)
            }
            _ = try dbLearningVerbDAO.insert(learningVerbs: dbUserLearningVerbs)
        }else{
            throw Database.shared.error!
        }
    }
}
