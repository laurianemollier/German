//
//  RevisionSessionState.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

struct RevisionSessionState {
    var isLoading: Bool
    var alertItem: AlertItem?
    
    var audioToggle: AudioToggleState = AudioToggleState()
    var flashcard: FlashcardState = FlashcardState()
    
    var index: Int
    var verbCount: Int
    var isSummaryActive: Bool
    var reviewVerbs: IdentifiedArrayOf<VerbReviewState>
    
    init(verbCount: Int, reviewVerbs: IdentifiedArrayOf<VerbReviewState>) {
        if(verbCount > 0) {
            self.isLoading = false
            
            self.index = 0
            self.verbCount = verbCount
            self.isSummaryActive = false
            self.reviewVerbs = reviewVerbs
        } else {
            self.isLoading = false
            
            self.index = -1
            self.verbCount = -1
            self.isSummaryActive = false
            self.reviewVerbs = []
            
            self.alertItem = AlertContext.internalError(CustomError.ReviewListEmpty)
        }
    }
    
    init() {
        self.isLoading = true
        
        self.index = -1
        self.verbCount = -1
        self.isSummaryActive = false
        self.reviewVerbs = []
    }
    
    func currentLearningVerb() -> LearningVerb? {
        reviewVerbs.first(where: {$0.id == index})?.learningVerb
    }
}
