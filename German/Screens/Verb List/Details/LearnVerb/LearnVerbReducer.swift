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
        state.isLoading = true
        do{
            let updatedOp = try DAO.shared.addVerbToReviewList(learningVerb: state.learningVerb)
            if let updated = updatedOp { return Effect(value: .verbUpdated(new: updated)) }
            else { return Effect(value: .verbUpdateFailure(CustomError.VerbNotFound)) }
        }
        catch{
            return Effect(value: .verbUpdateFailure(error))
        }
        
    case let .verbUpdated(newLearningVerb):
        state.isLoading = false
        state.learningVerb = newLearningVerb
        return .none
        
    case let .verbUpdateFailure(error):
        state.isLoading = false
        state.alertItem = AlertContext.internalError(error)
        return .none
    }
}

