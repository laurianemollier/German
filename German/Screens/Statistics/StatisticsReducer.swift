//
//  StatisticsReducer.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

// TODO: cancellable
let statisticsReducer: Reducer<StatisticsState, StatisticsAction, ()> =
verbListReducer
    .pullback(
        state: \Identified.value,
        action: .self,
        environment: { $0 }
    )
    .optional()
    .pullback(
        state: \StatisticsState.selection,
        action: /StatisticsAction.verbListDetails,
        environment: { _ in () }
    )
    .combined(with: verbListReducer
                .pullback(
                    state: \StatisticsState.userProgressionStatistics[id: UserProgression.level1]!.verbListState,
                    action: /StatisticsAction.verbListDetailsdd,
                    environment: { $0 }
                )
    )
    .combined(with: Reducer<StatisticsState, StatisticsAction, ()> { state, action, environment in
        switch(action) {
        case .verbListDetails(_):
            return .none
            
        case let .verbListDetailsdd(action):
            return .none
            
        case .loadState:
            return Effect(value: .verbListDetailsdd(.loadState)).eraseToEffect()
            
        case let .setUserProgression(selection: .some(selection)):
            state.selection = Identified(
                VerbListState.loading(userProgression: selection),
                id: selection
            )
            return .none
            // .cancellable(id: CancelId(), cancelInFlight: true)
            
        case .setUserProgression(selection: .none):
            if let selection = state.selection {
                state.userProgressionStatistics[id: selection.id]?.verbListState = selection.value
            }
            state.selection = nil
            return .none
            //            return .cancel(id: CancelId())
        }
    })

