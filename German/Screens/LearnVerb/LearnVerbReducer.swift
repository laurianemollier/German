//
//  LearnVerbReducer.swift
//  German
//
//  Created by Lauriane Mollier on 29.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

let learnVerbReducer = Reducer<LearnVerbState, LearnVerbAction, ()> { state, action, environment in
    switch(action) {
    case .infinitiveFormSeen:
        state.tenseDiscoveryState = LearnVerbState.TenseDiscoveryState.infinitiveFormSeen
        return .none
                
    case .presentFormSeen:
        state.tenseDiscoveryState = LearnVerbState.TenseDiscoveryState.presentFormSeen
        return .none
        
    case .simplePastFormSeen:
        state.tenseDiscoveryState = LearnVerbState.TenseDiscoveryState.simplePastFormSeen
        return .none
        
    case .pastParticipleFormSeen:
        state.tenseDiscoveryState = LearnVerbState.TenseDiscoveryState.allFormSeen
        return .none
        
    case .endLearnSession:
        return .none
    }
}

