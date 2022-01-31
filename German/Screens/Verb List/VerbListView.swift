//
//  VerbListView.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct VerbListView: View {
    var store: Store<VerbListState, VerbListAction>
    @ObservedObject var viewStore: ViewStore<VerbListState, VerbListAction>
    
    init(store: Store<VerbListState, VerbListAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        VStack {
            HStack{
                Picker("Level Filter",
                       selection: viewStore.binding(
                        get: \.selectedLevel,
                        send: VerbListAction.selecteLevel)
                ) {
                    Text("All level").tag(Level?.none)
                    ForEach(Level.allCases, id: \.self) { level in
                        Text(verbatim: "\(level)").tag(Level?.some(level))
                    }
                }
                
                Spacer()
                Picker("Level Form",
                       selection: viewStore.binding(
                        get: \.selectedForm,
                        send: VerbListAction.selecteForm)
                ) {
                    Text("All form").tag(Form?.none)
                    ForEach(Form.allCases, id: \.self) { form in
                        Text(verbatim: "\(form)").tag(Form?.some(form))
                    }
                }
                
                Spacer()
            }
            
            SearchBarView(store: self.store.scope(
                state: \.searchBar,
                action: VerbListAction.searchBar)
            )
            
            List(viewStore.filteredLearningVerbs){ learningVerb in
                NavigationLink(
                    tag: learningVerb,
                    selection: viewStore.binding(
                        get: \.selectedVerbDetail?.learningVerb,
                        send: VerbListAction.setLearningVerbDetail(selection:)
                    ),
                    destination: {
                        IfLetStore(
                            self.store.scope(
                                state: \.selectedVerbDetail,
                                action: VerbListAction.verbDetail
                            ),
                            then: VerbDetailView.init(store:),
                            else: ProgressView.init
                        )},
                    label: {
                        VerbListCell(verb: learningVerb.verb, viewMode: viewStore.cellViewMode)
                    }
                )
            }
        }.onAppear {
            viewStore.send(.loadState)
        }
    }
}
