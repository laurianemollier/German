//
//  VerbDetailView.swift
//  German
//
//  Created by Lauriane Mollier on 30.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct VerbDetailView: View {
    
    var store: Store<VerbDetailState, VerbDetailAction>
    @ObservedObject var viewStore: ViewStore<VerbDetailState, VerbDetailAction>
    
    init(store: Store<VerbDetailState, VerbDetailAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        if viewStore.verbProgressionDetail != nil {
            VerbProgressionDetailView(store:
                                        store.scope(
                                            state: \.verbProgressionDetail!,
                                            action: VerbDetailAction.verbProgression)
            )
        } else if viewStore.learnVerb != nil {
            LearnVerbView(store:
                            store.scope(
                                state: \.learnVerb!,
                                action: VerbDetailAction.learnVerb)
            )
        }
    }
}
