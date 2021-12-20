//
//  FlashcardReducer.swift
//  German
//
//  Created by Lauriane Mollier on 19.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

func FlashcardReducer(state: inout FlashcardState, action: FlashcardAction) -> [Effect<FlashcardAction>] {
    let animationTime = 0.5
    
    switch action {
    case .flipFlashcard:
        if (!state.flipped) {
            withAnimation(Animation.linear(duration: animationTime)) {
                state.flashcardRotation += 180
            }
            withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
                state.contentRotation += 180
                state.flipped = true
            }
        }
        return []
        
    case .resetFlashcard:
        state.flipped = false
        return []
    }
}
