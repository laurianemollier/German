//
//  StatisticsReducer.swift
//  German
//
//  Created by Lauriane Mollier on 09.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import ComposableArchitecture

let statisticsReducer = Reducer<StatisticsState, StatisticsAction, ()>.combine(
    verbListReducer // to refect change in the list of VerbListState
        .pullback(
            state: \StatisticsState.PerUserProgression.verbListState,
            action: .self,
            environment: { $0 }
        )
        .forEach(
            state: \StatisticsState.userProgressionStatistics,
            action: /StatisticsAction.verbLists(id:action:),
            environment: { $0 }
        ),
    verbListReducer // to refect change in the selected VerbListState
        .pullback(
            state: \Identified.value,
            action: .self,
            environment: { $0 }
        )
        .optional()
        .pullback(
            state: \StatisticsState.selection,
            action: /StatisticsAction.selectedVerbList,
            environment: { _ in () }
        ),
    Reducer<StatisticsState, StatisticsAction, ()> { state, action, environment in
        switch(action) {
            // TODO: lolo
//        case .selectedVerbList(VerbListAction.verbDetail(VerbDetailAction.verbUpdated)):
//            return Effect(value: .setUserProgression(.none))
            
        case .selectedVerbList(_), .verbLists:
            return .none
            
        case .loadState:
            return Effect.merge(
                state.userProgressionStatistics.elements.map{
                    Effect(value: StatisticsAction.verbLists(
                        id: $0.id,
                        action: VerbListAction.loadState)
                    ).eraseToEffect()
                }
            )
            
        case let .setUserProgression(selection: .some(selection)):
            state.selection = Identified(
                VerbListState.loading(userProgression: selection),
                id: selection
            )
            return .none
            
        case .setUserProgression(selection: .none):
            if let selection = state.selection {
                state.userProgressionStatistics[id: selection.id]?.verbListState = selection.value
            }
            state.selection = nil
            return .none
        }
    }
)
