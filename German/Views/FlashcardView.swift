//
//  FlashcardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI

struct FlashcardView<Front, Back>: View where Front: View, Back: View {
    
    @ObservedObject var viewModel: FlashcardViewModel
    
    private let front: () -> Front
    private let back: () -> Back
    private let onTapGestureAction: () throws -> Void
    
    init(viewModel: FlashcardViewModel,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back,
         onTapGestureAction: @escaping () throws -> Void) {
        self.viewModel = viewModel
        self.front = front
        self.back = back
        self.onTapGestureAction = onTapGestureAction
    }
    
    var body: some View {
        ZStack {
            if viewModel.flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(viewModel.contentRotation), axis: (x: 0, y: 1, z: 0))
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
            if (!viewModel.flipped) {
                viewModel.flipFlashcard()
            }
            
            do {
                try  onTapGestureAction()
            }
            catch {
                SpeedLog.print(error)
            }
           
        }
        .rotation3DEffect(.degrees(viewModel.flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
}
