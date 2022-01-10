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
    
    var store: Store<StatisticsState, StatisticsAction>
    @ObservedObject var viewStore: ViewStore<StatisticsState, StatisticsAction>
    
    init(store: Store<StatisticsState, StatisticsAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ForEach(viewStore.userProgressionStatistics ){ statistics in
                    NavigationLink(
                        destination: IfLetStore(
                            self.store.scope(
                                state: \.selection?.value,
                                action: StatisticsAction.verbListDetails
                            ),
                            then: VerbListView.init(store:),
                            else: ProgressView.init
                        ),
                        tag: statistics.userProgression,
                        selection: viewStore.binding(
                            get: \.selection?.id,
                            send: StatisticsAction.setUserProgression
                        ),
                        label: {
                            UserProgressionButton(
                                userProgression: statistics.userProgression,
                                verbCount: statistics.verbCount)
                        }
                    )
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}
