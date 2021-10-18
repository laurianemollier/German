//
//  DbVerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

final class LocalDbVerbDAO: DbVerbDAO{
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    func createTable() throws {
        SpeedLog.print("Create VerbTable...")
        try self.db.run(VerbTable.createTable)
        SpeedLog.print("VerbTable created")
    }
    
    /// Create a new ligne in the database to store this verb
    func insert(verb: DbVerb) throws -> DbVerb {
        
        SpeedLog.print("Insert DbVerb " + verb.infinitive + " ...")
        let insert = VerbTable.verbs.insert(VerbTable.level <- verb.level.rawValue,
                                            VerbTable.form <- verb.form.rawValue,
                                            VerbTable.infinitive <- verb.infinitive,
                                            VerbTable.present <- verb.present,
                                            VerbTable.simplePast <- verb.simplePast,
                                            VerbTable.pastParticiple <- verb.pastParticiple)
        
        let id: Int64 = try db.run(insert)
        SpeedLog.print("DbVerb inserted with id: " + String(id))
        return DbVerb(id: id, level: verb.level, form: verb.form,
                      infinitive: verb.infinitive, present: verb.present,
                      simplePast: verb.simplePast, pastParticiple: verb.pastParticiple)
    }
    
    func findAll() throws -> [DbVerb] {
        try db.prepare(VerbTable.verbs).map({verb in
            DbVerb(id: verb[VerbTable.id],
                   level: Level(rawValue: verb[VerbTable.level])!,
                   form: Form(rawValue: verb[VerbTable.form])!,
                   infinitive: verb[VerbTable.infinitive],
                   present: verb[VerbTable.present],
                   simplePast: verb[VerbTable.simplePast],
                   pastParticiple: verb[VerbTable.pastParticiple])
        })
    }
    
}




