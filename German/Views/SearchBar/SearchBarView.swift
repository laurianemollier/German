//
//  SearchBar.swift
//  German
//
//  Created by Lauriane Mollier on 10/10/21.
//  Copyright © 2021 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct SearchBarView: View {
    
    var store: Store<SearchBarState, SearchBarAction>
    @ObservedObject var viewStore: ViewStore<SearchBarState, SearchBarAction>
    
    init(store: Store<SearchBarState, SearchBarAction>) {
        self.store = store
        self.viewStore = ViewStore(self.store)
    }
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search terms here", text: viewStore.binding(
                    get: \.searchText,
                    send: { text in .textChanged(text)})
                ).padding(.leading, 24)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(6)
            .padding(.horizontal)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if viewStore.isSearching {
                        Button{ viewStore.send(.textChanged(""))} label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        }
                    }
                }.padding(.horizontal, 32).foregroundColor(.gray)
            ).transition(.move(edge: .trailing))
        }
    }
}
