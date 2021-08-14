//
//  DbVerbDAO.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


protocol DbVerbDAO{
    
    /// Create a new ligne in the database to store this verb
    func create(verb: Verb)
    
    func findAll() -> [Verb]
    
}
