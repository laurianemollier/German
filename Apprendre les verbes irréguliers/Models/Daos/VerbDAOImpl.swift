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
    
    let db: Connection = Database.shared.connection!
    
    static let shared = VerbDAOImpl()
    
    private init(){
        
    }
    
    
    
    func insert(verb: Verb)-> Verb {
        do {
            let dbVerb = try DbVerbDAOImpl.shared.insert(verb: verb.toDbVerb())
            let dbTranslations = try verb.toDbVerbTranslations(id: dbVerb.id!).map{ dbTrans in
                try DbVerbTranslationDAOImpl.shared.insert(translation: dbTrans)
            }
            return Verb(dbVerb: dbVerb, dbVerbTranslations: dbTranslations)
        }
        catch{
            // TODO
            print(error)
            return verb
        }
    }
    
    func insert(verbs: [Verb]) -> [Verb]{
        return verbs.map({ v in insert(verb: v)})
    }
  
}


