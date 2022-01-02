//
//  RevisionHomeReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture


struct RevisionHomeEnvironment { // TODO: lolo remove
    var mainQueue: AnySchedulerOf<DispatchQueue>
}

let revisionHomeReducer =
revisionSessionReducer
    .optional()
    .pullback(
        state: \.optionalRevisionSession,
        action: /RevisionHomeAction.optionalRevisionSession,
        environment: { _ in () }
    )
    .combined(
        with: Reducer<RevisionHomeState, RevisionHomeAction, RevisionHomeEnvironment> { state, action, environment in
            struct CancelId: Hashable {}
            switch action {
            case .setRevisionSession(isActive: true):
                state.isRevisionSessionActive = true
                state.optionalRevisionSession = RevisionSessionState.loading
                return Effect(value: .optionalRevisionSession(.loadState))
                    .eraseToEffect()
                    .cancellable(id: CancelId())
                
            case .setRevisionSession(isActive: false),
                    .optionalRevisionSession( .endRevisionSession):
                state.optionalRevisionSession = nil // TODO: delete ? (audio has to be stopped if removed)
                state.isRevisionSessionActive = false
                return .cancel(id: CancelId())
                
            case .optionalRevisionSession:
                return .none
                
            case .loadState:
                state.isLoading = true
                do {
                    // TODO: do that somewhere else
                    // If it is the first run of this app, set the database
                    if FirstLaunch().isFirstLaunch {
                        try SetUpDatabase.setUp()
                    }
                    
                    state.verbInReviewListCount = try DAO.shared.verbInReviewListCount()
                    state.verbToReviewTodayCount = try DAO.shared.verbToReviewTodayCount()
                    state.isLoading = false
                }
                catch {
                    state.alertItem = AlertContext.internalError(error)
                }
                
                return.none
            }
        }
    )
