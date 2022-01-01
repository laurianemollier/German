//
//  ReviewVerbState.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ReviewVerbState: Equatable, Identifiable {
    let id: Int
    var alertItem: AlertItem?
    
    var learningVerb: LearningVerb
    var verbReview: VerbReview?
    
    init(id: Int, learningVerb: LearningVerb) {
        self.id = id
        self.learningVerb = learningVerb
    }
}
    
struct ReviewVerbsFeatureState {
    var isLoading: Bool = false
    var alertItem: AlertItem?
    
    var audioToggle: AudioToggleState = AudioToggleState()
    var flashcard: FlashcardState = FlashcardState()
    
    var index: Int = 0
    var verbCount: Int = 0
    var reviewVerbs: IdentifiedArrayOf<ReviewVerbState> = []
    
    func currentLearningVerb() -> LearningVerb? {
        reviewVerbs.first(where: {$0.id == index})?.learningVerb
    }
}
