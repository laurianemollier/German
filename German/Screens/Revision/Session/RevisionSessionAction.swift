//
//  RevisionSessionAction.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//


enum RevisionSessionAction {
    case loadState
    case revealVerb
    case regressButtonTapped
    case stagnateButtonTapped
    case progressButtonTapped
    case endRevisionSession
    
    case audioToggle(AudioToggleAction)
    case flashcard(FlashcardAction)
    case reviewVerb(id: VerbReviewState.ID, action: VerbReviewAction)
    case nextVerb
}
