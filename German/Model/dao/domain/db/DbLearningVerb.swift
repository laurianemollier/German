//
//  DbUserLearningVerb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 17/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


class DbLearningVerb{
    
    let id: Int64
    
    let verbId: Int64
    
    let dateToReview: Date?
    
    let userProgression: String
    
    init(id: Int64, verbId: Int64, dateToReview: Date?, userProgression: String){
        self.id = id
        self.verbId = verbId
        self.dateToReview = dateToReview
        self.userProgression = userProgression
    }
}



