//
//  ReviewVerbReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

func ReviewVerbReducer(state: inout ReviewVerbState, action: ReviewVerbAction) -> [Effect<ReviewVerbAction>] {
    
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
        return []
        
    case .regress:
        verbReviewed(UserProgression.regression(_:reviewedDate:))
        return []
        
    case .stagnate:
        verbReviewed(UserProgression.stagnation(_:reviewedDate:))
        return []
        
    case .progress:
        verbReviewed(UserProgression.progression(_:reviewedDate:))
        return []
        
    case .endRevisionSession:
        state.isLoading = true
        do {
            let dbResultVerbsReviewed = state.resultVerbsReviewed.map({ $0.toDbUserLearningVerb()})
            _ = try DAO.shared.update(learningVerbs: dbResultVerbsReviewed)
            //            actionOnEndRevisionSession() // TODO: lolo
        } catch {
            state.alertItem = AlertContext.internalError(error)
        }
        return []
    }
}


let ReviewVerbViewReducer = combine(
  pullback(AudioToggleReducer, value: \ReviewVerbViewState.audioToggle, action: \ReviewVerbViewAction.audioToggle),
  pullback(FlashcardReducer, value: \.flashcard, action: \.flashcard),
  pullback(ReviewVerbReducer, value: \.reviewVerb, action: \.reviewVerb)
)
