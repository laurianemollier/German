//
//  flashcardReducer.swift
//  German
//
//  Created by Lauriane Mollier on 19.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let flashcardReducer = Reducer<FlashcardState, FlashcardAction, ()> { state, action, environment in    
    switch action {
    case .flipFlashcard:
        let animationTime = 0.5
        if (!state.flipped) {
            return Effect.merge(
                [
                    Effect(value: withAnimation { FlashcardAction.step(.rotateFlashcard) })
                        .delay(for: .seconds(0), scheduler: DispatchQueue.main.animation(.linear(duration: animationTime)))
                        .eraseToEffect(),
                    Effect(value: withAnimation { FlashcardAction.step(.rotateContent) })
                        .delay(for: .seconds(animationTime / 2), scheduler: DispatchQueue.main.animation(.linear(duration: 0.001)))
                        .eraseToEffect(),
                ]
            )
        } else {
            return .none
        }
       
    case .step(FlipStep.rotateFlashcard):
        state.flashcardRotation += 180
        return .none
        
    case .step(FlipStep.rotateContent):
        state.contentRotation += 180
        state.flipped = true
        return .none
        
    case .resetFlashcard:
        state.flipped = false
        return .none
    }
}
