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
        if (viewStore.isEndOfRevisionSession) {
            ReviewSummaryView(store: store)
                .navigationBarBackButtonHidden(true)
        } else {
            ReviewVerbsView(store: store)
                .onAppear{
                    viewStore.send(.loadVerbsToReview)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: BackButton(action: {
                    navigation.activeRevision = false
                }))
        }
        
    }
}

extension RevisionSessionView.State {
    init(reviewVerbFeatureState state: ReviewVerbsFeatureState) {
        self.isEndOfRevisionSession = state.isEndOfRevisionSession
    }
}

extension ReviewVerbsFeatureAction {
    init(action: RevisionSessionView.Action) {
        switch action {
        case .loadVerbsToReview:
            self = .loadVerbsToReview
        }
    }
}
