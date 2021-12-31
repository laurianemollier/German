//
//  reviewVerbReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let reviewVerbReducer = Reducer<ReviewVerbState, ReviewVerbAction, ()> { state, action, environment in
    
    func verbReviewed(_ review: (UserProgression, _ reviewedDate: Date) -> (UserProgression, Date)?) {
        if let currentVerb = state.currentLearningVerb,
           let currentReviewDate = currentVerb.dateToReview,
           let (newProgression, toReviewDate) = review(currentVerb.userProgression, currentReviewDate) {
            let updatedVerbReviewed = currentVerb.set(userProgression: newProgression, dateToReview: toReviewDate)
            state.resultVerbsReviewed.append(updatedVerbReviewed)
            state.index = min(state.index + 1, state.verbsToReview.count - 1)
            state.currentLearningVerb = state.verbsToReview[state.index]
        } else {
            state.alertItem = AlertContext.internalError(CustomError.IllegalState)
        }
    }
    
    switch action {
    case .loadVerbsToReview:
        state.isLoading = true
        do {
            state.verbsToReview = try DAO.shared.verbToReviewToday(limit: 10)
            if(state.verbsToReview.count > 0) {
                state.currentLearningVerb = state.verbsToReview[state.index]
                state.isLoading = false
            } else {
                state.alertItem = AlertContext.internalError(CustomError.ReviewListEmpty)
            }
        } catch {
            state.alertItem = AlertContext.internalError(error)
        }
        return .none
        
    case .regress:
        verbReviewed(UserProgression.regression(_:reviewedDate:))
        return .none
        
    case .stagnate:
        verbReviewed(UserProgression.stagnation(_:reviewedDate:))
        return .none
        
    case .progress:
        verbReviewed(UserProgression.progression(_:reviewedDate:))
        return .none
        
    case .endRevisionSession:
        state.isLoading = true
        do {
            let dbResultVerbsReviewed = state.resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
            _ = try DAO.shared.update(learningVerbs: dbResultVerbsReviewed)
            //            actionOnEndRevisionSession() // TODO: lolo
        } catch {
            state.alertItem = AlertContext.internalError(error)
        }
        return .none
    }
}

let reviewVerbFeatureReducer =
Reducer<ReviewVerbFeatureState, ReviewVerbFeatureAction, ()>.combine(
    audioToggleReducer.pullback(
        state: \.audioToggle,
        action: /ReviewVerbFeatureAction.audioToggle,
        environment: { $0 }
    ),
    flashcardReducer.pullback(
        state: \.flashcard,
        action: /ReviewVerbFeatureAction.flashcard,
        environment: { $0 }
    ),
    reviewVerbReducer.pullback(
        state: \.reviewVerb,
        action: /ReviewVerbFeatureAction.reviewVerb,
        environment: { $0 }
    )
)
