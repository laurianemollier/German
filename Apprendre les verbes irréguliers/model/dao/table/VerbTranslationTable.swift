//
//  VerbTranslationTable.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite


class VerbTranslationTable{
    
    static let translations = Table("verbTranslations")
    
    /// The id of the translation
    static let id = Expression<Int64>("id")
    
    /// The verb id for which the translation is
    static let verbId = Expression<Int64>("verbId")
    
    /// The language in which the translation is
    static let lang = Expression<String>("lang")
    
    /// The translation of the verb of id "id" in the language "lang"
    static let translation = Expression<String>("translation")
    
    /// The definition of the table that needs to be created
    static let createTable: String = VerbTranslationTable.translations.create{ (table) in
        table.column(VerbTranslationTable.id, primaryKey: .autoincrement)
        table.column(VerbTranslationTable.verbId)
        table.column(VerbTranslationTable.lang)
        table.column(VerbTranslationTable.translation)
        
        table.foreignKey(VerbTranslationTable.verbId, references: VerbTable.verbs, VerbTable.id, delete: .cascade)
    }
}
