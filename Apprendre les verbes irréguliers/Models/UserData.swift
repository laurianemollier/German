//
//  UserData.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 14/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


class UserData {
    
    // L'interphase avec la base de donné
    


    
    static func getVerbsToReviewOn(date: Date) -> [UserLearningVerb] {
        // TODO:
        return []
    }
    
    static func getVerbsToReviewToday() -> [UserLearningVerb] {
        // TODO:
        return []
    }
    
    static func getVerbsToReviewToday(number: Int) -> [UserLearningVerb] {
        // TODO:
        return []
    }
    
    static func getVerbsToReviewOn(date: Date, number: Int) -> [UserLearningVerb] {
        // TODO:
        return []
    }
    
    static func numberOfVerbToReviewToday() -> Int {
        // TODO
        return 1
    }
    
    
    
    
    
    
    
    
    
    
    
    // Here to remember
    

    
    
    static fileprivate let userDefaults = UserDefaults.standard
    static let separator = ";"
    

    static fileprivate func defautlKey(progression: UserProgression) -> String {
        //  TODO: chnage the name of the key
        return "LaurianeMollier" + progression.rawValue
    }

    
    static fileprivate func save(verbs: [Verb], progression: UserProgression){
        let ids: String = "What you want"
        userDefaults.setValue(ids, forKey: defautlKey(progression: progression))
        userDefaults.synchronize()
    }

    
}
