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
                            action: StatisticsAction.selectedVerbListDetails
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
                            userProgression: rowState.userProgression,
                            verbCount: rowState.verbCount
                        ) // TODO: if is loading
                    }
                )
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
                isLoading: false, // TODO: lolo
                userProgression: userProgressionStatistic.userProgression,
                verbCount: userProgressionStatistic.verbListState.learningVerbs.count
            )
        }
    }
}
