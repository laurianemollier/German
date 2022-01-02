//
//  RevisionSessionView.swift
//  German
//
//  Created by Lauriane Mollier on 01.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RevisionSessionView: View {
    
    struct State: Equatable {
        var activeSession: Bool = false
        var navigationBackButtonTapped: Bool // TODO: lolo isSummaryActive ? 
    }
    
    public enum Action {
        case loadVerbsToReview
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
        if (viewStore.navigationBackButtonTapped) {
            RevisionSummaryView(store: store)
                .navigationBarBackButtonHidden(true)
        } else {
            ReviewVerbsView(store: store)
                .onAppear{
                    viewStore.send(.loadVerbsToReview)
                }
        }
        
    }
}

extension RevisionSessionView.State {
    init(reviewVerbFeatureState state: RevisionSessionState) {
        self.navigationBackButtonTapped = state.isRevisionSessionEnded
    }
}

extension RevisionSessionAction {
    init(action: RevisionSessionView.Action) {
        switch action {
        case .loadVerbsToReview:
            self = .loadState
        }
    }
}
