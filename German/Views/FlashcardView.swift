//
//  FlashcardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct FlashcardView<Front, Back>: View where Front: View, Back: View {
    private let front: () -> Front
    private let back: () -> Back
    private let onTapGestureAction: () -> Void
    
    @Binding private var flipped: Bool
    @State private var flashcardRotation = 0.0
    @State private var contentRotation = 0.0
    
    let animationTime = 0.5
    
    init(flipped: Binding<Bool>,
    @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back,
        
         onTapGestureAction: @escaping () -> Void) {
        
        self.front = front
        self.back = back
        self.onTapGestureAction = onTapGestureAction
        self._flipped = flipped
    }
    
    var body: some View {
        ZStack {
            if flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .frame(height: 200)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            Rectangle()
                .stroke(Color.black, lineWidth: 2)
        )
        .padding()
        .onTapGesture {
            if (!flipped) {
                flipped = true
                flipFlashcard()
                onTapGestureAction()
            }
        }
        .rotation3DEffect(.degrees(flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
    
    func flipFlashcard() {
        if (!flipped) {
            
            withAnimation(Animation.linear(duration: animationTime)) {
                flashcardRotation += 180
            }
            
            withAnimation(Animation.linear(duration: 0.001).delay(animationTime / 2)) {
                contentRotation += 180
                flipped.toggle()
            }
        }
    }
}
