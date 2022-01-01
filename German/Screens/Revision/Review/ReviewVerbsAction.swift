//
//  ReviewVerbAction.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

enum ReviewVerbAction {
    case review(VerbReview)
    case updateVerb(userProgression: UserProgression, dateToReview: Date)
}

enum ReviewVerbsFeatureAction {
    case loadVerbsToReview
    case revealVerb
    case regressButtonTapped
    case stagnateButtonTapped
    case progressButtonTapped
    case endRevisionSession
    
    case audioToggle(AudioToggleAction)
    case flashcard(FlashcardAction)
    case reviewVerb(id: ReviewVerbState.ID, action: ReviewVerbAction)
    case nextVerb
}
