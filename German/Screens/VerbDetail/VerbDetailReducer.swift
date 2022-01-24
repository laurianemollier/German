//
//  VerbDetailReducer.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let verbDetailReducer = Reducer<VerbDetailState, VerbDetailAction, ()> { state, action, environment in
    switch(action) {
    case .addVerbToTheReviewList: // TODO: lolo
        state.isLoading = true
        do{
            let updatedOp = try DAO.shared.addVerbToReviewList(learningVerb: state.learningVerb)
            if let updated = updatedOp { return Effect(value: .verbUpdated(new: updated)) }
            else { return Effect(value: .verbUpdateFailure(CustomError.VerbNotFound)) }
        }
        catch{
            return Effect(value: .verbUpdateFailure(error))
        }
        
    case let .selectNewProgressionLevel(newLevel):  // TODO: lolo
        state.isLoading = true
        let (newProgression, dateToReview) = UserProgression.stagnation(newLevel, reviewedDate: Date())!
        
        do{
            let userLearningVerb = LearningVerb(id: state.learningVerb.id,
                                                verb: state.learningVerb.verb,
                                                dateToReview: dateToReview,
                                                userProgression: newProgression)
            let success = try DAO.shared.update(learningVerb: userLearningVerb.toDbUserLearningVerb())
            if success { return Effect(value: .verbUpdated(new: userLearningVerb)) }
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

