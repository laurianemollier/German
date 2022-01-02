//
//  RevisionSessionState.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture
import Darwin

struct RevisionSessionState {
    var isLoading: Bool
    var alertItem: AlertItem?
    
    var audioToggle: AudioToggleState = AudioToggleState()
    var flashcard: FlashcardState = FlashcardState()
    
    var index: Int = -1
    var verbCount: Int = -1
    var isSummaryActive: Bool = false
    var reviewVerbs: IdentifiedArrayOf<VerbReviewState> = []
    
    init(verbCount: Int, reviewVerbs: IdentifiedArrayOf<VerbReviewState>) {
        if(verbCount > 0) {
            self.isLoading = false
            self.index = 0
            self.verbCount = verbCount
            self.isSummaryActive = false
            self.reviewVerbs = reviewVerbs
        } else {
            self.isLoading = false
            self.alertItem = AlertContext.internalError(CustomError.ReviewListEmpty)
        }
    }
    
    fileprivate init() {
        self.isLoading = true
    }
    
    func currentLearningVerb() -> LearningVerb? {
        reviewVerbs.first(where: {$0.id == index})?.learningVerb
    }
    
    static let loading: RevisionSessionState = RevisionSessionState()
}
