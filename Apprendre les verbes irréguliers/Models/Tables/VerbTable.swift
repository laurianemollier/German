//
//  VerbTable.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import SQLite



class VerbTable{
    
    static let verbs = Table("verbs")
    
    /// The id for the verb
    static let id = Expression<Int64>("id")
    
    /// The level at which you are supposed to learn this verb.
    static let level = Expression<String>("level")
    
    /// The form to which the verb belongs.
    static let form = Expression<String>("form")
    
    /// The infinitive from of this verb
    static let infinitive = Expression<String>("infinitive")
    
    /// The present from of this verb
    static let present = Expression<String>("present")
    
    /// The simple past from of this verb
    static let simplePast = Expression<String>("simplePast")
    
    /// The past participle from of this verb
    static let pastParticiple = Expression<String>("pastParticiple")
    
    /// The definition of the table that needs to be created
    static let createTable: String = VerbTable.verbs.create { (table) in
        table.column(VerbTable.id, primaryKey: true)
        table.column(VerbTable.level)
        table.column(VerbTable.form)
        table.column(VerbTable.infinitive)
        table.column(VerbTable.present)
        table.column(VerbTable.simplePast)
        table.column(VerbTable.pastParticiple)
    }
}

