//
//  VerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import Foundation

protocol VerbDAO {
    func insert(verb: Verb) throws -> Verb
    
    func insert(verbs: [Verb]) throws -> [Verb]
    
    func find(id: Int64) throws -> Verb?
}
