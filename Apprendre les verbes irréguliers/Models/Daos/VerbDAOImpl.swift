//
//  VerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

class VerbDAOImpl/*: VerbDAO*/{
    
    // TODO: deal with the errors of connections
    let db: Connection = Database.shared.connection!
    
    init(){
        
    }
    
    func createTable(){
        do{
            // TODO with the possible errors
            try self.db.run(VerbTable.createTable)
        }
        catch{
            print(error)
        }
    }
    
    /// Create a new ligne in the database to store this verb
    func insert(verb: DbVerb) -> Int {
//        let insert = VerbTable.verbs.insert(level <- verb.level //TODO: to conintue)
//        let rowid = try db.run(insert)
    }
//
//    func findAll() -> [Verb] {
//
//    }
    
}




