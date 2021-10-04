//
//  FlashcardViewModel.swift
//  German
//
//  Created by Lauriane Mollier on 10/3/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

final class FlashcardViewModel: ObservableObject {
    
    // ------------------
    // MARK: - Variables
    // ------------------
    
    @Published var flipped: Bool = false
    @Published var flashcardRotation = 0.0
    @Published var contentRotation = 0.0
    
    let animationTime = 0.5
    
    func flipFlashcard() {
        if (!flipped) {
            withAnimation(Animation.linear(duration: animationTime)) {
                flashcardRotation += 180
            }
            withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
                contentRotation += 180
                flipped = true
            }
        }
    }
}
