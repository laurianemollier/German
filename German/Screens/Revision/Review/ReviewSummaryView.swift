//
//  ReviewSummaryView.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ReviewSummaryView: View {
    
    struct State: Equatable {
        var reviewVerbs: IdentifiedArrayOf<ReviewVerbState> = []
    }
    
    public enum Action {
        case endRevisionSession
    }
    
    var store: Store<ReviewVerbsFeatureState, ReviewVerbsFeatureAction>
    @ObservedObject var viewStore: ViewStore<State, Action>
    
    init(store: Store<ReviewVerbsFeatureState, ReviewVerbsFeatureAction>) {
        self.store = store
        self.viewStore = ViewStore(
            self.store.scope(
                state: State.init,
                action: ReviewVerbsFeatureAction.init
            )
        )
    }
    
    var body: some View {
        VStack {
            Button {viewStore.send(.endRevisionSession)} label: {
                Text("OK")
            }
        }
    }
}

extension ReviewSummaryView.State {
    init(reviewVerbFeatureState state: ReviewVerbsFeatureState) {
        self.reviewVerbs = state.reviewVerbs
    }
}

extension ReviewVerbsFeatureAction {
    init(action: ReviewSummaryView.Action) {
        switch action {
        case .endRevisionSession:
            self = .endRevisionSession
        }
    }
}
