//
//  RevisionHomeReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture


struct RevisionHomeEnvironment {
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
                return Effect(value: .setRevisionSessionIsActiveDelayCompleted)
                    .delay(for: 1, scheduler: environment.mainQueue) // TODO: lolo
                    .eraseToEffect()
                    .cancellable(id: CancelId())
                
            case .setRevisionSession(isActive: false),
                    .optionalRevisionSession( .endRevisionSession):
                state.isRevisionSessionActive = false
                state.optionalRevisionSession = nil
                return .cancel(id: CancelId())
                
            case .setRevisionSessionIsActiveDelayCompleted:
                state.optionalRevisionSession = RevisionSessionState()
                return .none
                
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
