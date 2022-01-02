//
//  RevisionSessionReducer.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import Combine
import ComposableArchitecture

let revisionSessionReducer = Reducer<RevisionSessionState, RevisionSessionAction, ()>.combine(
    audioToggleReducer.pullback(
        state: \.audioToggle,
        action: /RevisionSessionAction.audioToggle,
        environment: { $0 }
    ),
    flashcardReducer.pullback(
        state: \.flashcard,
        action: /RevisionSessionAction.flashcard,
        environment: { $0 }
    ),
    verbReviewReducer.forEach(
        state: \.reviewVerbs,
        action: /RevisionSessionAction.reviewVerb(id:action:),
        environment: { $0 }
    ),
    Reducer { state, action, _ in
        switch action {
        case .audioToggle, .flashcard, .reviewVerb:
            return .none
            
        case .nextVerb:
            let newIdx = state.index + 1
            state.isRevisionSessionEnded = newIdx >= state.verbCount
            state.index = min(newIdx, state.verbCount - 1)
            return .none
            
        case .loadState:
            state.isLoading = true
            do {
                let verbsToReview = try DAO.shared.verbToReviewToday(limit: 10)
                if(verbsToReview.count > 0) {
                    let verbReviewStates = verbsToReview.enumerated().map { index, learningVerb in
                        VerbReviewState(id: index, learningVerb: learningVerb)
                    }
                    state.verbCount = verbReviewStates.count
                    state.reviewVerbs = IdentifiedArray.init(uniqueElements: verbReviewStates)
                    
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
            var playAudioEffect: Effect<RevisionSessionAction, Never>
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
