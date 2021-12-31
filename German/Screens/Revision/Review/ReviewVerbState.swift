//
//  ReviewVerbState.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ReviewVerbState {
    var isLoading: Bool = false
    var alertItem: AlertItem?
    
    var index: Int = 0
    var currentLearningVerb: LearningVerb? // TODO: should not be empty
    
    var verbsToReview: [LearningVerb] = []
    var resultVerbsReviewed: [LearningVerb] = []
}
    
struct ReviewVerbFeatureState {
    var audioToggle: AudioToggleState = AudioToggleState()
    var flashcard: FlashcardState = FlashcardState()
    var reviewVerb: ReviewVerbState = ReviewVerbState()
}
    
