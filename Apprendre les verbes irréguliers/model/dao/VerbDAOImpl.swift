//
//  VerbDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


class VerbDAOImpl{
    
    let db: Connection
    
    private init(connection: Connection){
        self.db = connection
    }
    
    static let shared = VerbDAOImpl(connection: Database.shared.connection!)
    

    func find(id: Int64) throws -> Verb?{
        return Verbs.verbs.first(where: {$0.id == id})
        
//        let q = VerbTable.verbs.filter(id == VerbTable.verbs[VerbTable.id])
//            .join(VerbTranslationTable.translations,
//                  on: VerbTranslationTable.verbId == VerbTable.verbs[VerbTable.id])
//
//        let rows: AnySequence<Row> = try db.prepare(q)
////        let translations: (Lang, String) = rows.map{ r in
////            (Lang(rawValue: r[VerbTranslationTable.lang])!, r[VerbTranslationTable.translation])
////        }
//
//
//
////        let r = rows[0]
////        let verb = (r[VerbTable.infinitive], r[VerbTable.present], r[VerbTable.simplePast], r[VerbTable.pastParticiple])
//
//        for r in rows{
//            print(r[VerbTable.infinitive] + "  " + r[VerbTranslationTable.translation])
//        }
    }
    
    
    func insert(verb: Verb) throws -> Verb {
        let dbVerb = try DbVerbDAOImpl.shared.insert(verb: verb.toDbVerb())
        let dbTranslations = try verb.toDbVerbTranslations(id: dbVerb.id!).map{ dbTrans in
            try DbVerbTranslationDAOImpl.shared.insert(translation: dbTrans)
        }
        return Verb(dbVerb: dbVerb, dbVerbTranslations: dbTranslations)
    }
    
    func insert(verbs: [Verb]) throws -> [Verb]{
        return try verbs.map({ v in try insert(verb: v)})
    }
    
    
  
}


