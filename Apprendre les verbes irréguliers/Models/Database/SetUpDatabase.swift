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
            try createTables()
            try insertInitialsData()
        }else{
            throw Database.shared.error!
        }
    }
    
    static private func createTables() throws {
//        try DbVerbDAOImpl.shared.createTable()
//        try DbVerbTranslationDAOImpl.shared.createTable()
        try DbUserLearningVerbDAOImpl.shared.createTable()
    }
    
    static private func insertInitialsData() throws {
        let dbUserLearningVerbs = Verbs.verbs.map{ v in
            // TODO to put this one in real

            DbUserLearningVerb(id: 0, verbId: v.id,
                               dateToReview: nil,
                               userProgression: UserProgression.notSeenYet.rawValue)
        }
        _ = try DbUserLearningVerbDAOImpl.shared.insert(learningVerbs: dbUserLearningVerbs)
    }

}
