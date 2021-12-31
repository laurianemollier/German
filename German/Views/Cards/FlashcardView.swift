//
//  FlashcardView.swift
//  German
//
//  Created by Lauriane Mollier on 9/20/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import Combine
import ComposableArchitecture

struct FlashcardView<Front, Back>: View where Front: View, Back: View {
    
    let animationTime = 0.5
    
    enum Action {
        case flipFlashcard
    }
    
    private let front: () -> Front
    private let back: () -> Back
    
    var store: Store<FlashcardState, FlashcardAction>
    @ObservedObject var viewStore: ViewStore<FlashcardState, Action>
    
    
    init(store: Store<FlashcardState, FlashcardAction>,
         @ViewBuilder front: @escaping () -> Front,
         @ViewBuilder back: @escaping () -> Back) {
        self.store = store
        self.front = front
        self.back = back
        self.viewStore = ViewStore(self.store.scope(
            state: { $0 },
            action: FlashcardAction.init
        ))
    }
    
    var body: some View {
        ZStack {
            if viewStore.flipped {
                back()
            } else {
                front()
            }
        }
        .rotation3DEffect(.degrees(viewStore.contentRotation), axis: (x: 0, y: 1, z: 0))
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .overlay(
            Rectangle().stroke(Color.black, lineWidth: 2)
        )
        .padding()
        .onTapGesture {
            viewStore.send(.flipFlashcard)
        }
        .rotation3DEffect(.degrees(viewStore.flashcardRotation), axis: (x: 0, y: 1, z: 0))
    }
}

extension FlashcardAction {
    init<Front, Back>(action: FlashcardView<Front, Back>.Action) {
        switch action {
        case .flipFlashcard:
            self = FlashcardAction.flipFlashcard
        }
    }
}


// TODO: lolo
extension Scheduler {
    func animation(_ animation: Animation? = .default) -> AnySchedulerOf<Self> {
        .init(
            minimumTolerance: { self.minimumTolerance },
            now: { self.now },
            scheduleImmediately: { options, action in
                self.schedule(options: options) {
                    withAnimation(animation, action)
                }
            },
            delayed: { after, tolerance, options, action in
                self.schedule(after: after, tolerance: tolerance, options: options) {
                    withAnimation(animation, action)
                }
            },
            interval: { after, interval, tolerance, options, action in
                self.schedule(after: after, interval: interval, tolerance: tolerance, options: options) {
                    withAnimation(animation, action)
                }
            }
        )
    }
}

extension ViewStore {
    func send(_ action: Action, animation: Animation) {
        withAnimation(animation) {
            self.send(action)
        }
    }
}
