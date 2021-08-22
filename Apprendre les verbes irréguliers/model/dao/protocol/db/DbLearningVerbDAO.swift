//
//  DbLearningVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

protocol DbLearningVerbDAO {
    func createTable() throws
    
    func insert(learningVerb: DbLearningVerb) throws -> DbLearningVerb
    
    func insert(learningVerbs: [DbLearningVerb]) throws -> [DbLearningVerb]
}
