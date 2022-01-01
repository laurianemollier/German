//
//  reviewVerbReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import Combine
import ComposableArchitecture

let verbReviewReducer = Reducer<VerbReviewState, VerbReviewAction, ()> { state, action, environment in
    
    func verbReviewed(_ review: (UserProgression, _ reviewedDate: Date) -> (UserProgression, Date)?) -> Effect<VerbReviewAction, Never> {
        if let currentReviewDate = state.learningVerb.dateToReview,
           let (newProgression, toReviewDate) = review(state.learningVerb.userProgression, currentReviewDate) {
            return Just(.updateVerb(userProgression: newProgression, dateToReview: toReviewDate))
                .eraseToEffect()
        } else {
            state.alertItem = AlertContext.internalError(CustomError.IllegalState)
            return .none
        }
    }
    
    switch action {
    case .review(.regress):
        return verbReviewed(UserProgression.regression(_:reviewedDate:))
        
    case .review(.stagnate):
        return verbReviewed(UserProgression.stagnation(_:reviewedDate:))
        
    case .review(.progress):
        return verbReviewed(UserProgression.progression(_:reviewedDate:))
        
    case .updateVerb(userProgression: let userProgression, dateToReview: let dateToReview):
        do {
            let updatedVerbReviewed = state.learningVerb.set(userProgression: userProgression, dateToReview: dateToReview)
            _ = try DAO.shared.update(learningVerb: updatedVerbReviewed.toDbUserLearningVerb())
        } catch {
            state.alertItem = AlertContext.internalError(error)
        }
        return .none
    }
}
