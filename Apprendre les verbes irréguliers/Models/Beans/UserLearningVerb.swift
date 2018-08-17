//
//  UserLearningVerb.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 15/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation
import AVFoundation


/// This class represent the user's learning data for this verb
class UserLearningVerb{
    
    /// The verb that the user wants to review
    let verb: Verb
    
    /// The date at which the user has to review this verb
    let dateToReview: Date
    
    /// The progression of the user for this verb
    let userProgression: UserProgression
    
    
    /// Create a verb lerning process for this verb that is totally new for the user
    ///
    /// - Parameters:
    ///     - verb: The verb that the user wants to review
    ///
    /// - Returns: A new UserLearningVerb that is new for the user too
    init(verb: Verb){
        self.verb = verb
        self.dateToReview = Date()
        self.userProgression = UserProgression.level1
    }
    
    /// Create a verb lerning process for this verb that is already known by the user. (seen at least one time)
    ///
    /// - Parameters:
    ///     - verb: The verb that the user wants to review
    ///     - dateToReview: The date at which the user has to review this verb
    ///     - userProgression: The progression of the user for this verb
    ///
    /// - Returns: A new UserLearningVerb that is new for the user too
    init(verb: Verb, dateToReview: Date, userProgression: UserProgression){
        self.verb = verb
        self.dateToReview = dateToReview
        self.userProgression = userProgression
    }
    
}




