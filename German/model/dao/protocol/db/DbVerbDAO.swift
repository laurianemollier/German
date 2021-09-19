//
//  VerbDAOd.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 8/14/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

protocol DbVerbDAO {
    
    func createTable() throws
    
    func insert(verb: DbVerb) throws -> DbVerb
    
    func findAll() throws -> [DbVerb]
}
