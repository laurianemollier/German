//
//  DbVerbTranslation.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


class DbVerbTranslation{
    
    /// The id of the translation
    let id: Int64?
    
    /// The verb id for which the translation is
    let verbId: Int64
    
    /// The language in which the translation is
    let lang: Lang
    
    /// The translation of the verb of id "id" in the language "lang"
    let translation: String
    
    /// A translation of a verb that is stored in the database
    ///
    /// - Parameters
    ///     - id: The id of the translation
    ///     - verbId: The verb id for which the translation is
    ///     - lang: The language in which the translation is
    ///     - translation: The translation of the verb of id "id" in the language "lang"
    init(id: Int64?, verbId: Int64, lang: Lang, translation: String){
        self.id = id
        self.verbId = verbId
        self.lang = lang
        self.translation = translation
    }
}
