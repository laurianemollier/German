//
//  StatisticsView.swift
//  German
//
//  Created by Lauriane Mollier on 9/19/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct StatisticsView: View {
    
    struct State: Equatable {
        var selection: UserProgression?
        var rowStates: [RowState]
        
        struct RowState: Equatable {
            var isLoading: Bool
            var isDisabled: Bool
            var userProgression: UserProgression
            var verbCount: Int
        }
    }
    
    var store: Store<StatisticsState, StatisticsAction>
    @ObservedObject var viewStore: ViewStore<State, StatisticsAction>
    
    init(store: Store<StatisticsState, StatisticsAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store.scope(state: State.init(state:)))
    }
    
    var body: some View {
        VStack {
            ForEach(Array(viewStore.rowStates), id: \.userProgression){ rowState in
                NavigationLink(
                    destination: IfLetStore(
                        self.store.scope(
                            state: \.selection?.value,
                            action: StatisticsAction.selectedVerbList
                        ),
                        then: VerbListView.init(store:),
                        else: ProgressView.init
                    ),
                    tag: rowState.userProgression,
                    selection: viewStore.binding(
                        get: \.selection,
                        send: StatisticsAction.setUserProgression
                    ),
                    label: {
                        UserProgressionButton(
                            isLoading: rowState.isLoading,
                            isSelected: false,
                            userProgression: rowState.userProgression,
                            verbCount: rowState.verbCount
                        )
                    }
                ).disabled(rowState.isDisabled)
            }
        }
        .onAppear() {
            viewStore.send(.loadState)
        }
    }
}

extension StatisticsView.State {
    init(state: StatisticsState) {
        self.selection = state.selection?.userProgression
        self.rowStates = state.userProgressionStatistics.elements.map { userProgressionStatistic in
            RowState(
                isLoading: userProgressionStatistic.verbListState.isLoading,
                isDisabled: userProgressionStatistic.verbListState.learningVerbs.count <= 0,
                userProgression: userProgressionStatistic.id,
                verbCount: userProgressionStatistic.verbListState.learningVerbs.count
            )
        }
    }
}
