//
//  LearnVerbState.swift
//  German
//
//  Created by Lauriane Mollier on 29.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

struct LearnVerbState: Equatable {
    enum TenseDiscoveryState: Equatable {
        case start
        case infinitiveFormSeen
        case presentFormSeen
        case simplePastFormSeen
        case allFormSeen
    }
    
    
    var verb: Verb
    var tenseDiscoveryState: TenseDiscoveryState = TenseDiscoveryState.start
}

