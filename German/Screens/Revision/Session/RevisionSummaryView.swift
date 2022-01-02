//
//  ReviewSummaryView.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RevisionSummaryView: View {
    
    struct State: Equatable {
        var reviewVerbs: IdentifiedArrayOf<VerbReviewState> = []
    }
    
    public enum Action {
        case revisionSessionEndButtonTapped
    }
    
    var store: Store<RevisionSessionState, RevisionSessionAction>
    @ObservedObject var viewStore: ViewStore<State, Action>
    
    init(store: Store<RevisionSessionState, RevisionSessionAction>) {
        self.store = store
        self.viewStore = ViewStore(
            self.store.scope(
                state: State.init,
                action: RevisionSessionAction.init
            )
        )
    }
    
    var body: some View {
        VStack {
            Button {viewStore.send(.revisionSessionEndButtonTapped)} label: {
                Text("OK")
            }
        }
    }
}

extension RevisionSummaryView.State {
    init(reviewVerbFeatureState state: RevisionSessionState) {
        self.reviewVerbs = state.reviewVerbs
    }
}

extension RevisionSessionAction {
    init(action: RevisionSummaryView.Action) {
        switch action {
        case .revisionSessionEndButtonTapped:
            self = .endRevisionSession
        }
    }
}
