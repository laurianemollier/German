//
//  FirstLaunch.swift
//  Apprendre les verbes irréguliers
//
//  Created by Lauriane Mollier on 16/08/2018.
//  Copyright © 2018 Lauriane Mollier. All rights reserved.
//

import Foundation


final class FirstLaunch {

    let userDefaults: UserDefaults = .standard
    
    let wasLaunchedBefore: Bool
    let isFirstLaunch: Bool
    
    init() {
        let key = "org.lauriane-mollier.irregular-verbs.german" + "wasLaunchedBefore"
        let wasLaunchedBefore = userDefaults.bool(forKey: key)
        self.wasLaunchedBefore = wasLaunchedBefore
        self.isFirstLaunch = !wasLaunchedBefore
        
        if !wasLaunchedBefore {
            userDefaults.set(true, forKey: key)
        }
    }
    
    func execute(onFistLaunch: (() -> Void), whenWasLaunchedBefore: (() -> Void) ){
        if isFirstLaunch {onFistLaunch()}
        else {whenWasLaunchedBefore()}
    }
    
}
