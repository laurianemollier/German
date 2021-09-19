//
//  DbVerbTranslationDAOImpl.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite

final class LocalDbVerbTranslationDAO: DbVerbTranslationDAO{
    
    private let db: Connection
    
    init(connection: Connection){
        self.db = connection
    }
    
    func createTable() throws {
        SpeedLog.print("Create VerbTranslationTable...")
        try self.db.run(VerbTranslationTable.createTable)
        SpeedLog.print("VerbTranslationTable created")
    }
    
    func insert(translation: DbVerbTranslation) throws -> DbVerbTranslation{
        SpeedLog.print("Insert DbVerbTranslation " + translation.translation + " ...")
        
        let insert = VerbTranslationTable.translations
            .insert(VerbTranslationTable.verbId <- translation.verbId,
                    VerbTranslationTable.lang <- translation.lang.rawValue,
                    VerbTranslationTable.translation <- translation.translation)
        
        let id: Int64 = try db.run(insert)
        
        SpeedLog.print("DbVerb DbVerbTranslation with id: " + String(id) + ". For verb of id: " + String(translation.verbId))
        
        return DbVerbTranslation(id: id,
                                 verbId: translation.verbId,
                                 lang: translation.lang,
                                 translation: translation.translation)
        
    }
    
}
