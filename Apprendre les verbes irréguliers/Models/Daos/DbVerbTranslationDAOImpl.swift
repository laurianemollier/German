//
//  DbVerbTranslationDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


class DbVerbTranslationDAOImpl{
    
    // TODO: deal with the errors of connections
    let db: Connection = Database.shared.connection!
    
    static let shared = DbVerbTranslationDAOImpl()
    
    private init() {}
    
    func createTable(){
        do{
            // TODO with the possible errors
            print("Create VerbTranslationTable...")
            try self.db.run(VerbTranslationTable.createTable)
            print("VerbTranslationTable created")
        }
        catch{
            // TODO
            print(error)
        }
    }
    
    
    func insert(translation: DbVerbTranslation) throws -> DbVerbTranslation{
        print("Insert DbVerbTranslation " + translation.translation + " ...")
        let insert = VerbTranslationTable.translations
            .insert(VerbTranslationTable.verbId <- translation.verbId,
                    VerbTranslationTable.lang <- translation.lang.rawValue,
                    VerbTranslationTable.translation <- translation.translation)
        
        let id: Int64 = try db.run(insert)
        print("DbVerb DbVerbTranslation ")
        return DbVerbTranslation(id: id,
                                 verbId: translation.verbId,
                                 lang: translation.lang,
                                 translation: translation.translation)
        
    }

}
