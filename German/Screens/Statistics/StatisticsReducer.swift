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
Reducer<StatisticsState, StatisticsAction, ()>.combine(
    verbListReducer
        .pullback(
            state: \StatisticsState.userProgressionStatistics[id: UserProgression.level1]!.verbListState,
            action: /StatisticsAction.selectedVerbListDetails,
            environment: { $0 }
        ),
    verbListReducer
        .pullback(
            state: \Identified.value,
            action: .self,
            environment: { $0 }
        )
        .optional()
        .pullback(
            state: \StatisticsState.selection,
            action: /StatisticsAction.selectedVerbListDetails,
            environment: { _ in () }
        ),
    Reducer<StatisticsState, StatisticsAction, ()> { state, action, environment in
        switch(action) {
        case .selectedVerbListDetails(_):
            return .none
            
        case .storedVerbListDetails:
            return .none
            
        case .loadState:
            return Effect.merge(
                state.userProgressionStatistics.elements.map{
                    Effect(value: StatisticsAction.storedVerbListDetails(
                        id: $0.id,
                        VerbListAction.loadState)
                    ).eraseToEffect()
                }
            )
            //            return Effect(value: .selectedVerbListDetails(.loadState)).eraseToEffect()
            
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


//// TODO: cancellable
//let statisticsReducer: Reducer<StatisticsState, StatisticsAction, ()> =
//verbListReducer.forEach(
//    state: \StatisticsState.verbListStates,
//    action: /StatisticsAction.verbList(id:action:),
//    environment: { $0 }
//)
//    .combined(with: Reducer<StatisticsState, StatisticsAction, ()> { state, action, environment in
//        switch(action) {
//            
//        case .verbList:
//            return .none
//            
//        case .loadState:
//            return Effect.merge(
//                state.verbListStates.elements.map{
//                    Effect(value: StatisticsAction.verbList(
//                        id: $0.id,
//                        action: VerbListAction.loadState)
//                    ).eraseToEffect()
//                }
//            )
//        }
//    })

