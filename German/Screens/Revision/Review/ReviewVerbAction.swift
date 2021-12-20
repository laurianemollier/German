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
    case loadVerbsToReview
    case regress
    case stagnate
    case progress
    case endRevisionSession
}


enum ReviewVerbViewAction {
    case audioToggle(AudioToggleAction)
    case flashcard(FlashcardAction)
    case reviewVerb(ReviewVerbAction)
    
    var audioToggle: AudioToggleAction? {
      get {
        guard case let .audioToggle(value) = self else { return nil }
        return value
      }
      set {
        guard case .audioToggle = self, let newValue = newValue else { return }
        self = .audioToggle(newValue)
      }
    }

    var flashcard: FlashcardAction? {
      get {
        guard case let .flashcard(value) = self else { return nil }
        return value
      }
      set {
        guard case .flashcard = self, let newValue = newValue else { return }
        self = .flashcard(newValue)
      }
    }
    
    var reviewVerb: ReviewVerbAction? {
      get {
        guard case let .reviewVerb(value) = self else { return nil }
        return value
      }
      set {
        guard case .reviewVerb = self, let newValue = newValue else { return }
        self = .reviewVerb(newValue)
      }
    }
}
