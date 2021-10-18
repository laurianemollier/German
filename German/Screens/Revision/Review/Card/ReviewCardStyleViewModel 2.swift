//
//  ReviewStyleView.swift
//  German
//
//  Created by Lauriane Mollier on 10/17/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

protocol ReviewCardStyleViewModel {

    func flashcardView(verb: Verb) -> AnyView
    
    func areAllCardsFlipped() -> Bool
    
    func flipAllCards() -> Void
    
    func resetAllCards() -> Void
    
}
