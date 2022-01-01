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
        var isEndOfRevisionSession: Bool
    }
    
    public enum Action {
        case loadVerbsToReview
    }
    
    @EnvironmentObject var navigation: RevisionNavigationModel
    
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
        if (viewStore.isEndOfRevisionSession) {
            RevisionSummaryView(store: store)
                .navigationBarBackButtonHidden(true)
        } else {
            ReviewVerbsView(store: store)
                .onAppear{
                    viewStore.send(.loadVerbsToReview)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton(action: {
                    navigation.activeSession = false
                }))
        }
        
    }
}

extension RevisionSessionView.State {
    init(reviewVerbFeatureState state: RevisionSessionState) {
        self.isEndOfRevisionSession = state.isEndOfRevisionSession
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
