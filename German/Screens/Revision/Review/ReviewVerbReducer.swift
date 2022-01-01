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

let reviewVerbReducer = Reducer<ReviewVerbState, ReviewVerbAction, ()> { state, action, environment in
    
    func verbReviewed(_ review: (UserProgression, _ reviewedDate: Date) -> (UserProgression, Date)?) -> Effect<ReviewVerbAction, Never> {
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

let reviewVerbsFeatureReducer =
Reducer<ReviewVerbsFeatureState, ReviewVerbsFeatureAction, ()>.combine(
    audioToggleReducer.pullback(
        state: \.audioToggle,
        action: /ReviewVerbsFeatureAction.audioToggle,
        environment: { $0 }
    ),
    flashcardReducer.pullback(
        state: \.flashcard,
        action: /ReviewVerbsFeatureAction.flashcard,
        environment: { $0 }
    ),
    reviewVerbReducer.forEach(
        state: \.reviewVerbs,
        action: /ReviewVerbsFeatureAction.reviewVerb(id:action:),
        environment: { $0 }
    ),
    Reducer { state, action, _ in
        switch action {
        case .audioToggle, .flashcard, .reviewVerb:
            return .none
            
        case .nextVerb:
            let newIdx = state.index + 1
            state.isEndOfRevisionSession = newIdx >= state.verbCount
            state.index = min(newIdx, state.verbCount - 1)
            return .none
            
        case .loadVerbsToReview:
            state.isLoading = true
            do {
                let verbsToReview = try DAO.shared.verbToReviewToday(limit: 10)
                if(verbsToReview.count > 0) {
                    let reviewVerbStates = verbsToReview.enumerated().map { index, learningVerb in
                        ReviewVerbState(id: index, learningVerb: learningVerb)
                    }
                    state.verbCount = reviewVerbStates.count
                    state.reviewVerbs = IdentifiedArray.init(uniqueElements: reviewVerbStates)
                    
                    state.isLoading = false
                } else {
                    state.alertItem = AlertContext.internalError(CustomError.ReviewListEmpty)
                }
            } catch {
                state.alertItem = AlertContext.internalError(error)
            }
            return .none
            
        case .endRevisionSession:
            return .none
            
        case .revealVerb:
            var playAudioEffect: Effect<ReviewVerbsFeatureAction, Never>
            if let currentLearningVerb = state.currentLearningVerb() {
                playAudioEffect = Just(.audioToggle(.audioPlay(verb: currentLearningVerb.verb, playVerbAudio: PlayVerbAudio.all))).eraseToEffect()
            } else {
                playAudioEffect = Effect.none
            }
            
            return Effect.merge(
                Just(.flashcard(.flipFlashcard)).eraseToEffect(),
                playAudioEffect
            )
            
        case .regressButtonTapped:
            return Effect.merge(
                Just(.reviewVerb(id: state.index, action: .review(.regress))).eraseToEffect(),
                Just(.audioToggle(.audioStop)).eraseToEffect(),
                Just(.flashcard(.resetFlashcard)).eraseToEffect(),
                Just(.nextVerb).eraseToEffect()
            )
            
        case .stagnateButtonTapped:
            return Effect.merge(
                Just(.reviewVerb(id: state.index, action: .review(.stagnate))).eraseToEffect(),
                Just(.audioToggle(.audioStop)).eraseToEffect(),
                Just(.flashcard(.resetFlashcard)).eraseToEffect(),
                Just(.nextVerb).eraseToEffect()
            )
            
        case .progressButtonTapped:
            return Effect.merge(
                Just(.reviewVerb(id: state.index, action: .review(.progress))).eraseToEffect(),
                Just(.audioToggle(.audioStop)).eraseToEffect(),
                Just(.flashcard(.resetFlashcard)).eraseToEffect(),
                Just(.nextVerb).eraseToEffect()
            )
        }
    }
)
