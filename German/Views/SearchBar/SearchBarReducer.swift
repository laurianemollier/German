//
//  SearchBarReducer.swift
//  German
//
//  Created by Lauriane Mollier on 03.01.22.
//  Copyright © 2022 Lauriane Mollier. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

let searchBarReducer = Reducer<SearchBarState, SearchBarAction, ()> { state, action, environment in
    switch(action){
    case let .textChanged(text):
        state.searchText = text
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            state.isSearching = false
        } else {
            state.isSearching = true
        }
        return .none
    }
}
