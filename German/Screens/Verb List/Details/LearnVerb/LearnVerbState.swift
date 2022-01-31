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
    
    private(set) var learningVerb: LearningVerb
    private(set) var verb: Verb
    var tenseDiscoveryState: TenseDiscoveryState
    
    init(learningVerb: LearningVerb) {
        self.learningVerb = learningVerb
        self.verb = learningVerb.verb
        self.tenseDiscoveryState = TenseDiscoveryState.start
    }
    
}
