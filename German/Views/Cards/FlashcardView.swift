//
//  FlashcardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct FlashcardView<Front, Back>: View where Front: View, Back: View {
    
    @ObservedObject var store: Store<FlashcardState, FlashcardAction>
    
    private let front: () -> Front
    private let back: () -> Back
  
    init(store: Store<FlashcardState, FlashcardAction>,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.store = store
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            if store.value.flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(store.value.contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            Rectangle().stroke(Color.black, lineWidth: 2)
        )
        .padding()
//        .onTapGesture {
//            if (!store.value.flipped) {
//                store.send(.flipFlashcard)
//            }
//
//            do {
//                try  onTapGestureAction()
//            }
//            catch {
//                SpeedLog.print(error)
//            }
//
//        }
        .rotation3DEffect(.degrees(store.value.flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
}
