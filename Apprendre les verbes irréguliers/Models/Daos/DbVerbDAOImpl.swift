//
//  DbVerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

class DbVerbDAOImpl/*: VerbDAO*/{
    
    // TODO: deal with the errors of connections
    let db: Connection = Database.shared.connection!
    
    private init(){
        
    }
    
    static let shared = DbVerbDAOImpl()

    func createTable(){
        do{
            // TODO with the possible errors
            print("Create VerbTable...")
            try self.db.run(VerbTable.createTable)
            print("VerbTable created")
        }
        catch{
            // TODO
            print(error)
        }
    }
    
    /// Create a new ligne in the database to store this verb
    func insert(verb: DbVerb) throws -> DbVerb {
        print("Insert DbVerb " + verb.infinitive + " ...")
        let insert = VerbTable.verbs.insert(VerbTable.level <- verb.level.rawValue,
                                            VerbTable.form <- verb.form.rawValue,
                                            VerbTable.infinitive <- verb.infinitive,
                                            VerbTable.present <- verb.present,
                                            VerbTable.simplePast <- verb.simplePast,
                                            VerbTable.pastParticiple <- verb.pastParticiple)
        
        let id: Int64 = try db.run(insert)
        print("DbVerb inserted ")
        return DbVerb(id: id, level: verb.level, form: verb.form,
                      infinitive: verb.infinitive, present: verb.present,
                      simplePast: verb.simplePast, pastParticiple: verb.pastParticiple)
        
        
//        do{
//            let id: Int64 = try db.run(insert)
//            print("Verb inserted " + verb.infinitive)
//            return DbVerb(id: id, level: verb.level, form: verb.form,
//                          infinitive: verb.infinitive, present: verb.present,
//                          simplePast: verb.simplePast, pastParticiple: verb.pastParticiple)
//        }
//        catch{
//            // TODO
//            print(error)
//            return nil
//        }
        
    }

    func findAll() -> [DbVerb] {
        do{
            let dbVerbs: [DbVerb] = try db.prepare(VerbTable.verbs).map({verb in
                DbVerb(id: verb[VerbTable.id],
                       level: Level(rawValue: verb[VerbTable.level])!,
                       form: Form(rawValue: verb[VerbTable.form])!,
                       infinitive: verb[VerbTable.infinitive],
                       present: verb[VerbTable.present],
                       simplePast: verb[VerbTable.simplePast],
                       pastParticiple: verb[VerbTable.pastParticiple])
            })
            
            return dbVerbs
        }
        catch{
            // TODO
            print(error)
            return [DbVerb]()
        }
    }
    
}




