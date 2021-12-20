//
//  RevisionHomeReducer.swift
//  German
//
//  Created by Lauriane Mollier on 18.12.21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public func revisionHomeReducer(state: inout RevisionHomeState, action: RevisionHomeAction) -> [Effect<RevisionHomeAction>] {
    switch action {
    case .refreshState:
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
        return []
    }
}
