//
//  ReviewVerbAction.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture


// TODO: to refactor to be associated with only one verb ?
enum ReviewVerbAction {
    case loadVerbsToReview
    case regress
    case stagnate
    case progress
    case endRevisionSession
}


enum ReviewVerbFeatureAction {
    case audioToggle(AudioToggleAction)
    case flashcard(FlashcardAction)
    case reviewVerb(ReviewVerbAction)
}
