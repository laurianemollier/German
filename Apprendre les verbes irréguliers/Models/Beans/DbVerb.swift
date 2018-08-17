//
//  DbVerb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation

/// The data of a verb that is store in the VerbTable
class DbVerb{
    
    /// The id for the verb
    let id: Int64?
    
    /// The level at which you are supposed to learn this verb.
    let level: Level
    
    /// The form to which the verb belongs.
    let form: Form
    
    /// The infinitive from of this verb
    let infinitive: String
    
    /// The present from of this verb
    let present: String
    
    /// The simple past from of this verb
    let simplePast: String
    
    /// The past participle from of this verb
    let pastParticiple: String
    
    
    /* Constructor */
    
    /// A verb that is store in the VerbTable
    ///
    /// - Parameters:
    ///     - id: The id of the verb
    ///     - level: The level at which you are supposed to learn this verb.
    ///     - form: The form to which the verb belongs.
    ///     - infinitive: The infinitive from of this verb
    ///     - present: The present from of this verb
    ///     - simplePast: The simple past from of this verb
    ///     - pastParticiple: The past participle from of this verb
    init(id: Int64?, level: Level, form: Form, infinitive: String, present: String, simplePast: String, pastParticiple: String){
        self.id = id
        self.level = level
        self.form = form
        self.infinitive = infinitive
        self.present = present
        self.simplePast = simplePast
        self.pastParticiple = pastParticiple
    }
}



