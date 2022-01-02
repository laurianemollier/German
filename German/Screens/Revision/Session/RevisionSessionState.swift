//
//  RevisionSessionState.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

struct RevisionSessionState {
    var isLoading: Bool = false
    var alertItem: AlertItem?
    
    var audioToggle: AudioToggleState = AudioToggleState()
    var flashcard: FlashcardState = FlashcardState()
    
    var index: Int = 0
    var verbCount: Int = 0
    var isRevisionSessionEnded = false
    var reviewVerbs: IdentifiedArrayOf<VerbReviewState> = []
    
    func currentLearningVerb() -> LearningVerb? {
        reviewVerbs.first(where: {$0.id == index})?.learningVerb
    }
}
