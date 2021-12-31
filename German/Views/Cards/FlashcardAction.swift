//
//  FlashcardAction.swift
//  German
//
//  Created by Lauriane Mollier on 19.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

enum FlipStep {
    case rotateFlashcard
    case rotateContent
}

enum FlashcardAction {
    case flipFlashcard
    case step(FlipStep)
    case resetFlashcard
}
